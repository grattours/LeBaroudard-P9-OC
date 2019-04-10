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
    
//    var locationManager = CLLocationManager()
//    var userPosition: CLLocation?
//    var pois: [Poi] = PoiCollection().all()
//    var poiSource: Poi?
//    var latidudeInit : Double = 47.310897
//    var longitudeInit : Double = -31.293182
    var coordinatesInit : CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 47.310897, longitude: -31.293182)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // ouverture de la carte sur le milieu de la distance Paris New York
        let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
        let region = MKCoordinateRegion(center: coordinatesInit, span: span)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        
        let paris = Poi(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.858370, longitude: 12.294481), info: "La tour Eiffeil mesure 324 mètres de hauteur.")
        let newyork = Poi(title: "New York", coordinate: CLLocationCoordinate2D(latitude: 40.689545, longitude: -74.044929), info: "La statue de la Liberté mesure 92,9 mètres")
        
 //        mapView.addAnnotations([paris, newyork])
        mapView.addAnnotations([paris, newyork])
    }
    
    @IBAction func ChangeMapTypeButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 : mapView.mapType = MKMapType.standard
        case 1 : mapView.mapType = .satellite
        case 2 : mapView.mapType = .hybrid
        default: break
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Poi else { return nil }
        let identifier = "Poi"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let poi = view.annotation as? Poi else { return }
        let placeName = poi.title
        let placeInfo = poi.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    
}
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if locations.count > 0 {
//            if let maPosition = locations.last {
//                userPosition = maPosition
//            }
//        }
//    }
//
//    func addAnnotations() {
//        // print(pois)
//        for poi in pois {
//            // Annotation custo
//            print(poi)
//            let annotation = MyAnnotation(poi)
//            print(annotation)
//            mapView.addAnnotation(annotation)
//            // print("after anno")
//            // Annotation de base
// //          let annotation = MKPointAnnotation()
// //           annotation.coordinate = poi.coordinates
////            annotation.title = poi.name
////            mapView.addAnnotation(annotation)
//        }
//    }
//
//    func setupMap(coordonnees: CLLocationCoordinate2D, myLat: Double, myLong: Double) {
//        let span = MKCoordinateSpan(latitudeDelta: myLat , longitudeDelta: myLong)
//        let region = MKCoordinateRegion(center: coordonnees, span: span)
//        mapView.setRegion(region, animated: true)
//    }
//
//
//    @objc func notifDetail(notification: Notification) {
//        //        if let oeuvre = notification.object as? Oeuvre {
//        //            print("j'ai une oeuvre")
//        //            toDetail(oeuvre: oeuvre)
//    }
//    //    }
//
//    //    @IBAction func getPosition(_ sender: Any) {
//    //        if userPosition != nil {
//    //            setupMap(coordonnees: userPosition!.coordinate, myLat: 1, myLong: 1)
//    //        }
//    //    }

//
//    @IBAction func getPositionButton(_ sender: Any) {
//        if userPosition != nil {
//            setupMap(coordonnees: userPosition!.coordinate, myLat: 0.01, myLong: 0.02)
//        }
//    }
// }
