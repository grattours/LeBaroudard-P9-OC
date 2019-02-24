//
//  ButtonView.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 23/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import UIKit

class ButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // ronds
        //        layer.cornerRadius = frame.size.width / 2
        //        layer.masksToBounds = true
        // coins arrondis
        // tintColor = UIColor.white
        //        backgroundColor = UIColor.lightGray
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        layer.cornerRadius = 10
        //        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
    }
    
}
