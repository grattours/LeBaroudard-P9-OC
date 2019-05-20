//
//  Extensions.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import UIKit

extension Date {
// return date in french text
    func toString() -> String {
        let formatter = DateFormatter()
        //formatter.dateStyle = .long
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "dd/MM/yyyy  HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "CET")
        return(formatter.string(from: self))
    }
    func toStringNY() -> String {
        let formatter = DateFormatter()
        //formatter.dateStyle = .long
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "dd/MM/yyyy  HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "EDT")
        return(formatter.string(from: self))
    }
// returns hh mm ss from a date
    func toHHMSS() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return(formatter.string(from: self))
    }
}
// Hide keyboard on Tap gesture
extension UIViewController {
    func hideKeyboardWhenTappedArrond() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
// same alerte with title and message as parameter
    func presentAlert(message: errorMessage) {
        let alertVC = UIAlertController(title: "Alerte", message: message.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}

// convertit une vue en image, élégant non ?
extension UIView {
    var image: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

// more simple to manipulate  custom colors
extension UIColor {
    public class var marron: UIColor {
        return UIColor(red: 106/255, green: 99/255, blue: 87/255, alpha: 1)
    }
    public class var jaune: UIColor {
        return UIColor(red: 217/255, green: 204/255, blue: 154/255, alpha: 1)
    }
    
    public class var vert: UIColor {
        return UIColor(red: 196/255, green: 214/255, blue: 184/255, alpha: 1)
    }
    public class var bleu: UIColor {
        return UIColor(red: 86/255, green: 111/255, blue: 146/255, alpha: 1)
    }
}

// convert color for UserDefault
extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {  // uiView.backgroundColor = defaults.colorForKey(key: "BackColor")
        if let colorData = data(forKey: key),
            let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        {
            return color
        } else {
            return nil
        }
    }
    
    func setColor(color: UIColor?, forKey key: String) { // defaults.setColor(color: uicolorBack, forKey: "BackColor")
        if let color = color,
            let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        {
            set(colorData, forKey: key)
        }
    }
}
