//
//  GeolocationViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 20/03/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import MapKit

class GeolocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var userPosition: CLLocation?
    
    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            print("if  view")
        }
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        print(" fin if view")
    }
    
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        print("MapViewController viewWillAppear")
    //        if userPosition != nil {
    //            print("not nil")
    //                    setupMap(coordonnees: userPosition!.coordinate, myLat: 1, myLong: 1)
    //        }
    //        setupMap(coordonnees: userPosition!.coordinate, myLat: 1, myLong: 1)
    //        setupMap(coordonnees: coord, myLat: 0.01 , myLong: 0.02)
    //        if let oeuvre1 = oeuvreSource {
    //            let coord = oeuvre1.coordonnee
    //            setupMap(coordonnees: coord, myLat: 0.01 , myLong: 0.02)
    //        }
    //    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location Manager")
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.mapView.setRegion(viewRegion, animated: true)
        if locations.count > 0 {
            if let maPosition = locations.last {
                userPosition = maPosition
            }
        }
    }
    
    func setupMap(coordonnees: CLLocationCoordinate2D, myLat: Double, myLong: Double) {
        print("setupMap")
        let span = MKCoordinateSpan(latitudeDelta: myLat , longitudeDelta: myLong)
        let region = MKCoordinateRegion(center: coordonnees, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @objc func notifDetail(notification: Notification) {
        //        if let oeuvre = notification.object as? Oeuvre {
        //            print("j'ai une oeuvre")
        //            toDetail(oeuvre: oeuvre)
    }
    //    }
    
    //    @IBAction func getPosition(_ sender: Any) {
    //        if userPosition != nil {
    //            setupMap(coordonnees: userPosition!.coordinate, myLat: 1, myLong: 1)
    //        }
    //    }
    @IBAction func ChangeMapTypeButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 : mapView.mapType = MKMapType.standard
        case 1 : mapView.mapType = .satellite
        case 2 : mapView.mapType = .hybrid
        default: break
        }
    }
    
    @IBAction func getPositionButton(_ sender: Any) {
        print("button geo")
        if userPosition != nil {
            print("nil")
            setupMap(coordonnees: userPosition!.coordinate, myLat: 1, myLong: 1)
        }
    }
}
