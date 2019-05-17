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
    @IBOutlet var uiView: UIView!
    @IBOutlet weak var firstChangeTextField: UITextField!
    @IBOutlet weak var secondChangeTextField: UITextField!
    @IBOutlet weak var colorButtons: UIStackView!
    
        var changeService = ChangeService()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedArrond()
            let defaults = UserDefaults.standard
            if (defaults.object(forKey: "BackColor") != nil) {
                uiView.backgroundColor = defaults.colorForKey(key: "BackColor")
            } else {
                uiView.backgroundColor = .marron
            }
            roundButtons()
        }
    
    // launch conversion
        @IBAction func ConvertButton(_ sender: Any) {
            guard firstChangeTextField.text  != "" else {
                self.presentAlert(message: .errorChangeInput)
                return
            }
            setupCurrencyData()
            firstChangeTextField.text = ""
            secondChangeTextField.text = ""
        }
    
    // Background color selection
        @IBAction func changeBackgroundColor(_ sender: UIButton) {
            uiView.backgroundColor = sender.backgroundColor
            let defaults = UserDefaults.standard
            let uicolorBack = uiView.backgroundColor
            defaults.setColor(color: uicolorBack, forKey: "BackColor")
            //defaults.set(uicolorBack, forKey: "BackColor")
    }
    
    // make button colors rounded
    func roundButtons() {
        for case let button as UIButton in colorButtons.subviews {
            button.layer.cornerRadius = button.frame.size.width / 2
        }
    }
    
    // data from currency API
         private func setupCurrencyData() {
            var AmountToConvert = 0.0
            guard let AmountInput = firstChangeTextField else {return}
            if let amount = AmountInput.text {
                let amountD = Double(amount)
                AmountToConvert = amountD ?? 0.0
            } else {
                return
            }
            changeService.firstAmountToConvert = AmountToConvert
            changeService.getChange() { (success, data) in
                if success, let currentRate = data?.rates?.USD {
                    DollarRate.rate = currentRate
                    
                    guard let rate = DollarRate.rate else { return }
                    let totalConverted = AmountToConvert * rate
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.locale = Locale(identifier: "fr-FR")
                    if let input = formatter.string(for: AmountToConvert) {
                        self.firstChangeTextField.text = input + " €"
                    }
                    if let output = formatter.string(for: totalConverted) {
                        self.secondChangeTextField.text = output + " $"
                    }
                } else {
                    self.presentAlert(message: .errorChangeConverter)
                }
            } // end getweather
        } // end setup
        
}
