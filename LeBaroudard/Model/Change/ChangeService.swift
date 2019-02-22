//
//  CurrencyService.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

class CurrencyService{
    var firstAmountToConvert = 0.0
    private var task: URLSessionTask?
    let currencySession: URLSession
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    func createCurrencyRequest()-> String {
        //let OptionRequest = "&base=EUR&symbols=USD"
        let ApiKeyRequest = valueForAPIKey(named:"API_Fixer")
        let Currency01 = "EUR"
        let Currency02 = "USD"
        let  URLString = "http://data.fixer.io/api/latest?access_key=\(ApiKeyRequest)&base=\(Currency01)&symbols=\(Currency02)"
        print("request")
        print(URLString)
        return(URLString)
    }
    
    func getCurrency(callback: @escaping(Bool, CurrencyStruct?) -> Void) {
        guard let url = URL(string: createCurrencyRequest()) else { return }
        task = currencySession.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    callback(false, nil)
                    print("error data")
                    return
                }
                guard error == nil else {
                    callback(false, nil)
                    print("error not nil")
                    return
                }
                guard  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("error response")
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(CurrencyStruct.self, from: data)
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

