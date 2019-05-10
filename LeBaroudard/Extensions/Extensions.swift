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
        let alertVC = UIAlertController(title: "Erreur", message: message.rawValue, preferredStyle: .alert)
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
