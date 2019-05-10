//
//  Currency.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

//API Struct. Currency
struct ChangeStruct: Decodable {
    let success: Bool
    let timestamp: Double?
    let base: String?
    let date: String?
    let rates: Rates?
}

struct Rates: Decodable {
    let USD: Double?
}

struct DollarRate {
    static var rate: Double?
    static var error: String?
}
