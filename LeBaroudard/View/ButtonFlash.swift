//
//  ButtonFlash.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 03/04/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import UIKit

class ButtonFlash: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
    }
    
}
