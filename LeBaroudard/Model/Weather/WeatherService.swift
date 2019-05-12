//
//  WeatherService.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
// New Yok  5128581
// Colombes 3024266

class WeatherService {
    
    private var task: URLSessionDataTask?
    private let weatherSession: URLSession
    init(weatherSession:URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
     // compose url endpoint with cities ids and options
     private func createWeatherRequest() -> String {
        let OptionsRequest = "&units=metric&lang=fr"
        let ApiKeyRequest = valueForAPIKey(named:"API_OpenWeathermap")
        let City01Id = "5128581"
        let City02Id = "3024266"
        let  URLString = "http://api.openweathermap.org/data/2.5/group?id=\(City01Id),\(City02Id)\(OptionsRequest)&APPID=\(ApiKeyRequest)"
        return URLString
    }
     // request service gpsweather
    func getWeather(callback: @escaping(Bool, WeatherStruc?) -> Void) {
        guard let url = URL(string: createWeatherRequest()) else {
            return }
        task = weatherSession.dataTask(with: url, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    callback(false, nil)
                    return
                }
                guard error == nil else {
                    callback(false, nil)
                    return
                }
                guard  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherStruc.self, from: data)
                    else { // lecture JSON
                        callback(false, nil)
                        return
                }
                callback(true, responseJSON)
            }
        })
        task?.resume()
    }  
    
}  // end class
