//
//  FakeResponseData.swift
//  LeBaroudardTests
//
//  Created by Luc Derosne on 25/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    // Fake data
    static var weatherCorrecteData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data =  try! Data(contentsOf: url!)
        return data
    }
    
    //    static var currencyCorrecteData: Data {
    //        let bundle = Bundle(for: FakeResponseData.self)
    //        let url = bundle.url(forResource: "Currency", withExtension: "json")
    //        let data =  try! Data(contentsOf: url!)
    //        return data
    //    }
    
    //    static var translationCorrecteData: Data {
    //        let bundle = Bundle(for: FakeResponseData.self)
    //        let url = bundle.url(forResource: "Currency", withExtension: "json")
    //        let data =  try! Data(contentsOf: url!)
    //        return data
    //    }
    
    
    // simulation d'un json endommagé
    static let  incorrectData = " data error".data(using: .utf8)!
    
    // Fake responses
    static let responseOK = HTTPURLResponse(url: URL(string: "http://google.com")!, statusCode: 200, httpVersion: nil, headerFields:  nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    // Fake error
    class FakeError: Error {} // error est un protocole, on ne peut pas en créer une instance
    static let error = FakeError()   // je crée donc une classe pour obtenir une instance du protocole
}
