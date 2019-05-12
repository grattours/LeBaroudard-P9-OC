//
//  WeatherViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    // outlet
    @IBOutlet weak var topTown: UILabel!
    @IBOutlet weak var topCondition: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topTemperature: UILabel!
    @IBOutlet weak var topDate: UILabel!

    @IBOutlet weak var botTown: UILabel!
    @IBOutlet weak var botCondition: UILabel!
    @IBOutlet weak var botImage: UIImageView!
    @IBOutlet weak var botTemperature: UILabel!
    @IBOutlet weak var botDate: UILabel!

    // instance
    var weatherService = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupJetLagData()
        setupWeatherData()
    }
    // data from weather API
     private func setupWeatherData() {
        weatherService.getWeather() { (success, weatherStruc) in
            if success {
                guard let weatherStruc = weatherStruc else {return}
                if let tempTop = weatherStruc.list[0].main.temp {
                    self.topTemperature.text = String(tempTop) + "°C"
                }
                self.topTown.text = weatherStruc.list[0].name
                self.topCondition.text = weatherStruc.list[0].weather[0].description
                if let icoT = weatherStruc.list[0].weather[0].icon {
                      self.topImage.image = UIImage(named: icoT)
                }
                self.botTown.text = weatherStruc.list[1].name
                if let tempBot = weatherStruc.list[1].main.temp {
                    self.botTemperature.text = String(tempBot) + "°C"
                }
                self.botCondition.text = weatherStruc.list[1].weather[0].description
                if let icoB = weatherStruc.list[1].weather[0].icon {
                    self.topImage.image = UIImage(named: icoB)
                }
             } else {
                self.presentAlert(message: .errorWeatherReception)
            }
        } // end getweather
    } // end setup

    // why not calculate the difference ?
     private func setupJetLagData() {
        botDate.text = ("\(Date().toString())")
        topDate.text = ("\(Date().toStringNY())")
        }

    } // end class

