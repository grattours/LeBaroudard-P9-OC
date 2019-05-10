//
//  ChangeViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {
    
    // outlet
        @IBOutlet weak var firstChangeTextField: UITextField!
        @IBOutlet weak var secondChangeTextField: UITextField!
        
        var changeService = ChangeService()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedArrond()
        }
        
        @IBAction func ConvertButton(_ sender: Any) {
            setupCurrencyData()
        }
    
    // data from currency API
        func setupCurrencyData() {
            guard let AmountInput = firstChangeTextField else {return}
            guard let AmountToConvert = Double(AmountInput.text!) else { return }
            changeService.firstAmountToConvert = AmountToConvert
            changeService.getChange() { (success, data) in
                if success, let currentRate = data?.rates?.USD {
                    DollarRate.rate = currentRate
                    
                    let rate = DollarRate.rate
                    let totalConverted = AmountToConvert * rate!
                    self.secondChangeTextField.text = String(format: "%.2f", totalConverted)
                } else {
                    self.presentAlert(message: .errorChangeConverter)
                }
            } // end getweather
        } // end setup
        
}
