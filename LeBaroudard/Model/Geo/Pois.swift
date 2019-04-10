//
//  Places.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 09/04/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import MapKit
import UIKit

class Poi: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

//class Poi {
//
//    private var _name: String
//    private var _desc: String
//    private var _place: String
//    private var _latitude: Double
//    private var _longitude: Double
//
//    var name: String {
//        return _name
//    }
//
//    var desc: String {
//        return _desc
//    }
//
//    var place: String {
//        return _place
//    }
//    var coordinates: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude)
//    }
//
//    init(name: String, desc: String, place: String, latitude: Double, longitude: Double) {
//        _name = name
//        _desc = desc
//        _place = place
//        _latitude = latitude
//        _longitude = longitude
//    }
//}
