//
//  Translate.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

// Api Struct Google Traduction
struct TranslationAPIResult: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String?
}

// to reverse languages
struct LangageTranslation {
    static var source = "fr"
    static var target = "en"
}
