//
//  TranslateViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // outlet
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    @IBOutlet weak var targetLanguageLabel: UILabel!
    @IBOutlet weak var sourceText: UITextView!
    @IBOutlet weak var targetText: UITextView!
    // instance
    var translateService = TranslateService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedArrond()
    }

    @IBAction func TranslateButton(_ sender: Any) {
        if sourceText.text != "" {
            translateText()
        }
    }
    
    @IBAction func reverse(_ sender: Any) {
        print("reverse")
        reverserSourceTarget()
    }
    
    @IBAction func Clear(_ sender: Any) {
        clearTexts()
    }
    
    // clear source and target texts
    func clearTexts() {
        sourceText.text = nil
        targetText.text = nil
        LangageTranslation.source = "fr"
        LangageTranslation.target = "en"
        // alert ?
    }
    
    // reverse source and target language
    func reverserSourceTarget() {
        print("reverseSourceTarget")
        let TextIn = sourceText.text
        let TextOut = targetText.text
        let TextTemp = sourceText.text
        
        if sourceLanguageLabel.text == "French" {
            sourceLanguageLabel.text = "US"
            targetLanguageLabel.text = "French"
            sourceText.text = targetText.text
            targetText.text = TextTemp
            LangageTranslation.source = "en"
            LangageTranslation.target = "fr"
        } else { // source = "US"
            sourceLanguageLabel.text = "French"
            targetLanguageLabel.text = "US"
            sourceText.text = TextIn
            targetText.text = TextOut
            LangageTranslation.source = "fr"
            LangageTranslation.target = "en"
            sourceText.text = targetText.text
            targetText.text = TextTemp
        }
        
    }
    
    // data from the API
    func translateText() {
        translateService.getTranslation(InputText: sourceText.text!) {(success, translatedText) in
            if success {
                guard let translatedText  = translatedText else { return }
                self.targetText.text = translatedText
            } else {
                print(" translation failed" )
            }
        }
    }
    
}

