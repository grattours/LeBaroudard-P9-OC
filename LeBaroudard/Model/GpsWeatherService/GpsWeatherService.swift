//
//  GpsWeatherService.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 06/05/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//
//
import Foundation
// New Yok  5128581
// Colombes 3024266

class GpsWeatherService {
    
    private var task: URLSessionDataTask?
    let weatherSession: URLSession
    init(weatherSession:URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
}
    // compose url endpoint with localisation
    func createGpsWeatherRequest(_ loc2: String) -> String {
        let OptionsRequest = "&units=metric&lang=fr"
        let ApiKeyRequest = valueForAPIKey(named:"API_OpenWeathermap")
        let  URLString = "http://api.openweathermap.org/data/2.5/weather?\(loc2)\(OptionsRequest)&APPID=\(ApiKeyRequest)"
        return URLString
    }
    
    // request service gpsweather
    func getWeather(_ loc3:String, callback: @escaping(Bool, GpsWeatherStruc?) -> Void) {
        guard let url = URL(string: createGpsWeatherRequest(loc3)) else {
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
                guard let responseJSON = try? JSONDecoder().decode(GpsWeatherStruc.self, from: data)
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
