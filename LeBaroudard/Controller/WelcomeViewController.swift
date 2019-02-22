//
//  WelcomeViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func CurrencyButton(_ sender: Any) {
        tabBarController!.selectedIndex = 3
        
    }
    
    @IBAction func weatherButton(_ sender: Any) {
        tabBarController!.selectedIndex = 1
    }
    
    @IBAction func translateButton(_ sender: Any) {
        tabBarController!.selectedIndex = 2
    }
}
