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
    
    private func createTranslateRequest(inputText:String) -> String {
        guard let textInUrl = inputText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return ""}
        //let OptionsRequest = "&units=metric&lang=fr"
        let ApiKeyRequest = valueForAPIKey(named:"API_GoogleTranslation")
        //     guard let encodedText = textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return ""}
        let targetLang = "en"
        //let sourceLang = "fr"
        //  let  URLString = "http://api.openweathermap.org/data/2.5/group?id=\(City01Id),\(City02Id)\(OptionsRequest)\(ApiKeyRequest)"
        let  URLString = "https://translation.googleapis.com/language/translate/v2?key=\(ApiKeyRequest)&target=\(targetLang)&format=text&q=\(textInUrl)"
        return URLString
    }
    
    
    func getTranslation(InputText:String, callback: @escaping(Bool, TranslationAPIResult?)-> Void) {
        guard let url = URL(string: createTranslateRequest(inputText: InputText )) else {return}
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
                guard let responseJSON = try? JSONDecoder().decode(TranslationAPIResult.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        })
        task?.resume()
    }
}

