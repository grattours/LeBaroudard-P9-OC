//
//  Weather.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

struct WeatherStruct: Decodable {
    let list: [List]
}
struct List: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}
struct Main: Decodable {
    let temp: Double
}
// ajout icon
struct Weather: Decodable {
    let main, description, icon: String
}
