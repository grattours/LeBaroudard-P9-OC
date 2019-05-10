//
//  Weather.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//
//

// API Struct the same for Weather and GpsWeather
import Foundation


// for endpoint with coordinate
struct GpsWeatherStruc: Decodable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Clouds: Decodable {
    let all: Int?
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Main: Decodable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Sys: Decodable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: Int?
}

struct Weather: Decodable {
    let id: Int?
    let main, description, icon: String?
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
}

// for endpoint with towns ids
struct WeatherStruc: Decodable {
    let list: [List]
}

struct List: Decodable {
    let coord: Coord?
    let weather: [Weather]
    let main: Main
    let name: String
}
