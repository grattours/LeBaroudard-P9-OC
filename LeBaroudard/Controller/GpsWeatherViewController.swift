//
//  GpsWeatherViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 06/05/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GpsWeatherViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var GpsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countryLoc: UILabel!

    //    @IBOutlet weak var gpTown: UILabel!
    @IBOutlet weak var gpCondition: UILabel!
    @IBOutlet weak var gpDate: UILabel!
    @IBOutlet weak var gpImage: UIImageView!
    @IBOutlet weak var gpTemperature: UILabel!

    var gpsWeatherService = GpsWeatherService()
    var locToWeather : String = ""
    var previousLocation: CLLocation?
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        print(locToWeather)
//    }
    // at start setup location manager and autorisation
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            self.presentAlert(message: .errorGpsWeatherLocationManager)
        }
    }
    
    // setuo location manager
    func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    
    // weather data from the location
    func setupWeatherData(_ loc4: String) {
        gpsWeatherService.getWeather(loc4) { (success, gpsWeatherStruc) in
            if success {
                guard let gpsWeatherStruc = gpsWeatherStruc else {
                    return }
                if let temp = gpsWeatherStruc.main?.temp {
                    self.gpTemperature.text = String(temp) + "°C"
                }
                if let cond = gpsWeatherStruc.weather?[0].description {
                    self.gpCondition.text = cond
                }
                self.gpImage.image = UIImage(named: gpsWeatherStruc.weather?[0].icon ?? "")
                self.gpDate.text = ("\(Date().toString())")
            } else {
                //self.presentAlert(message: .errorWeatherReception)
                // no meteo everywhere on the planet for the API !
            }
        } // end getweather
    } // end setup

    // locate user on the map
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }

    // center the map with user location
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        } else {
            self.presentAlert(message: .errorGpsWeatherCenterLoc)
        }
    }

    // compose endpoint parameters for weather API
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        let locWeather =  "lat=" + String(format: "%.04f", (latitude)) + "&lon=" + String(format: "%.04f", (longitude))
        setupWeatherData(locWeather)
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    // cases of autorisations or not
    func checkLocationAuthorization() {

        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // faire une alerte "autoriser la localisation"
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // faire une alerte
            break
        case .authorizedAlways:
            startTackingUserLocation()
            break
        @unknown default:
            fatalError()

        }
    }

} // end class


// -------------------------------------------------- EXTENSIONS - DELEGATE ----------------------------------------

// autorisation has changeg
extension GpsWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

//  region has changed - geoCoding for placemark infos
extension GpsWeatherViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center

        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }

            if let _ = error {
                // self.presentAlert(message: .errorGpsWeatherGeocoder)
                print("geocoder not dispo")
                return
            }

            guard let placemark = placemarks?.first else {
                return
            }
            let lat = String(format: "%.04f", (placemark.location?.coordinate.longitude ?? 0.0))
            let lon = String(format: "%.04f", (placemark.location?.coordinate.latitude ?? 0.0))
            let country = placemark.country ?? ""
            let locality = placemark.locality ?? ""
            // print(placemark.administrativeArea ?? "")

            self.GpsLabel.text = "\(lat) \(lon)"
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""

            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
                self.GpsLabel.text = "lat \(lat) long \(lon)"
                self.locToWeather = "lat=\(lat)&lon=\(lon)"
                self.countryLoc.text = "\(locality) \(country)"

            } // dispatch
        }// geocoder
    } // func mapview
} // extension
