//
//  CurrencyService.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

class ChangeService {
    var firstAmountToConvert = 0.0
    private var task: URLSessionTask?
    private let changeSession: URLSession
    init(changeSession: URLSession = URLSession(configuration: .default)) {
        self.changeSession = changeSession
    }
    // compose endpoint for API
     private func createChangeRequest()-> String {
        let ApiKeyRequest = valueForAPIKey(named:"API_Fixer")
        let Change01 = "EUR"
        let Change02 = "USD"
        let  URLString = "http://data.fixer.io/api/latest?access_key=\(ApiKeyRequest)&base=\(Change01)&symbols=\(Change02)"
        return(URLString)
    }
    
    // request
    func getChange(callback: @escaping(Bool, ChangeStruct?) -> Void) {
        guard let url = URL(string: createChangeRequest()) else { return }
        task = changeSession.dataTask(with: url, completionHandler: { (data, response, error) in
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
                
                guard let responseJSON = try? JSONDecoder().decode(ChangeStruct.self, from: data)
                    else { // lecture JSON
                        callback(false, nil)
                        return
                }
                callback(true, responseJSON)
            }
        })
        task?.resume()
    }  // end queue
    
}  // end class

