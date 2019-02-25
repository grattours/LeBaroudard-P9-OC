//
//  FakeResponseData.swift
//  LeBaroudardTests
//
//  Created by Luc Derosne on 25/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    // silulation du Json renvoyé par l'API
    static var weatherCorrecteData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
   
    
    // simulation d'un json endommagé
    static let  weatherIncorrectData = "erreur".data(using: .utf8)!
    // let imageData = "image".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://google.com")!, statusCode: 200, httpVersion: nil, headerFields:  [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://google.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class QuotError: Error {} // error est un protocole, on ne peut pas en créer une instance
    let error = QuotError()   // je crée donc une classe pour obtenir une instance du protocole
}
