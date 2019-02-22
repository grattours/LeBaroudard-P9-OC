//
//  TranslateViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {


    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var textTranslated: UITextView!

    var translateService = TranslateService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedArrond()
    }

    @IBAction func TranslateButton(_ sender: Any) {
        if textToTranslate.text != "" {
            requestTranslationData()
        }
        
    }
//
//    @IBAction func dissmiss(_ sender: UIGestureRecognizer) {
//        dismiss(animated: true, completion: nil)
//        textToTranslate.resignFirstResponder()
//    }
    
    
    func requestTranslationData() {
        print("translation")
        translateService.getTranslation(InputText: textToTranslate.text!) {(success, translatedText) in
            if success {
                print("success translation")
                guard let translatedText  = translatedText else { return }
                for i in translatedText.data.translations {
                    self.textTranslated.text = i.translatedText
                }
            } else {
                print(" translation failed" )
            }
            //        guard case textToTranslate.text  == "" else { return }
            //        guard let AmountInput = firstCurrencyTextField else {return}
            //        guard let AmountToConvert = Double(AmountInput.text!) else { return }
            //        currencyService.firstAmountToConvert = AmountToConvert
            //        currencyService.getCurrency() { (success, data) in
            //            if success, let currentRate = data?.rates?.USD {
            //                DollarRate.rate = currentRate
            //                // self.firstCurrencyTextField.text = "150"
            //                let rate = DollarRate.rate
            //                let totalConverted = AmountToConvert * rate!
            //                self.secondCurrencyTextField.text = String(format: "%.2f", totalConverted)
        }
    }
}

//extension UIViewController {
//    func hideKeyboardWhenTappedArrond() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dissmissKeyboard() {
//        view.endEditing(true)
//    }
//}
