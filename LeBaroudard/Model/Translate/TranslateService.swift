//
//  TranslateService.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

class TranslateService {
    
    private var task: URLSessionDataTask?
    private let translateSession:URLSession
    init(translateSession:URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
     // compose url endpoint with text and languages in/out
    private func createTranslateRequest(inputText:String, from:String, to:String) -> String {
        guard let textInUrl = inputText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return ""}
        let ApiKeyRequest = valueForAPIKey(named:"API_GoogleTranslation")
        let  URLString = "https://translation.googleapis.com/language/translate/v2?key=\(ApiKeyRequest)&source=\(from)&target=\(to)&format=text&q=\(textInUrl)"
        return URLString
    }
    
    // request service translation
    func getTranslation(InputText:String, callback: @escaping(Bool, String?)-> Void) {
        let source = LangageTranslation.source
        let target = LangageTranslation.target
        guard let url = URL(string: createTranslateRequest(inputText: InputText, from: source, to: target )) else {return}
        task?.cancel()
        task = translateSession.dataTask(with: url, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {   
                    callback(false, nil )
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslationAPIResult.self, from: data), let translate = responseJSON.data.translations[0].translatedText   else {
                    callback(false, nil)
                    return
                }
                callback(true, translate)
            }
        })
        task?.resume()
    }
}

