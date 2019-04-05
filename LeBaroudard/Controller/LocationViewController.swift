//
//  LocationViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 19/03/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var ui_StackSwip: UIStackView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
  //      locationManager.startUpdatingLocation()
        swipToShare()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let hightFromSeaLevel = location.altitude
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            let timeStamp = location.timestamp
            let speed = location.speed
            let direction = location.course
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 2
            let GpsFormatter = NumberFormatter()
            GpsFormatter.minimumFractionDigits = 0
            GpsFormatter.maximumFractionDigits = 7
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .medium
            let heureFormatter = DateFormatter()
            heureFormatter.dateFormat = "hh:mm:ss"
            let speedFormatter = NumberFormatter()
            speedFormatter.minimumFractionDigits = 0
            speedFormatter.maximumFractionDigits = 2
            let directionFormatter = NumberFormatter()
            directionFormatter.minimumFractionDigits = 0
            directionFormatter.maximumFractionDigits = 1
            
            altitudeLabel.text = numberFormatter.string(for: hightFromSeaLevel)! + " m"
            longitudeLabel.text = GpsFormatter.string(for: longitude)
            latitudeLabel.text = GpsFormatter.string(for: latitude)
            dateLabel.text = dateFormatter.string(from: timeStamp)
            heureLabel.text = heureFormatter.string(from: timeStamp)
            speedLabel.text = speedFormatter.string(from: NSNumber(value: speed))
            directionLabel.text = directionFormatter.string(from: NSNumber(value: direction))
            speedLabel.text = speed < 0 ? "Immobile" : "\(speed) m/s"
            directionLabel.text = direction < 0 ? "Immobile" : "\(direction)"

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
    // extract from ViewDidload - allows gesture up and left
    fileprivate func swipToShare() {
        // manage the swip - left for landscape up for portrait
        let left = UISwipeGestureRecognizer(target : self, action : #selector(LocationViewController.swipe))
        left.direction = .left
        self.ui_StackSwip.addGestureRecognizer(left)
        
        let up = UISwipeGestureRecognizer(target : self, action : #selector(LocationViewController.swipe))
        up.direction = .up
        self.ui_StackSwip.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target : self, action : #selector(LocationViewController.swipe))
        down.direction = .down
        self.ui_StackSwip.addGestureRecognizer(down)
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(LocationViewController.swipe))
        right.direction = .right
        self.ui_StackSwip.addGestureRecognizer(right)
    }
    
    // action on the gesture according to the meaning
    @objc
    func swipe(){
        let imageView = UIImageView(image: ui_StackSwip.image)
        let contentToshare: UIImage = imageView.image!
        let activity = UIActivityViewController(activityItems: [contentToshare], applicationActivities: nil )
        present(activity,animated: true, completion: nil)
    }
    
}
