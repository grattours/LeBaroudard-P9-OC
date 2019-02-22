//
//  ChangeViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 22/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {


        @IBOutlet weak var firstCurrencyLabel: UILabel!
        @IBOutlet weak var secondCurrencyLabel: UILabel!
        
        @IBOutlet weak var firstCurrencyTextField: UITextField!
        @IBOutlet weak var secondCurrencyTextField: UITextField!
        
        var currencyService = CurrencyService()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedArrond()
        }
        
        @IBAction func ConvertButton(_ sender: Any) {
            setupCurrencyData()
        }
        
        func setupCurrencyData() {
            guard let AmountInput = firstCurrencyTextField else {return}
            guard let AmountToConvert = Double(AmountInput.text!) else { return }
            currencyService.firstAmountToConvert = AmountToConvert
            currencyService.getCurrency() { (success, data) in
                if success, let currentRate = data?.rates?.USD {
                    DollarRate.rate = currentRate
                    
                    let rate = DollarRate.rate
                    let totalConverted = AmountToConvert * rate!
                    self.secondCurrencyTextField.text = String(format: "%.2f", totalConverted)
                    //self.secondCurrencyTextField.text = "200"
                    // let currentRate = dollarRate.rate
                    //let currentRate = currencyStruct.rates[self.firstCurrencyTextField.text!] ?? 0
                    //                guard let secondAmount = Double(AmountInput.text!) else { return }
                    //                let totalConverted = currentRate! * secondAmount
                    //                self.secondCurrencyTextField.text = String(format: "%.2f", totalConverted)
                    
                    //                self.topCondition.text = weatherStruc.list[0].weather[0].description
                    //                self.botTown.text = weatherStruc.list[1].name
                    //                self.botTemperature.text = String(weatherStruc.list[1].main.temp) + "°C"
                    //                self.botCondition.text = weatherStruc.list[1].weather[0].description
                    
                } // end success
            } // end getweather
        } // end setup
        
}
