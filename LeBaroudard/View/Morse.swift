//
//  Morse.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 03/04/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import AVFoundation

class Morse {
    
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    
    // turn the flash on with flashbutton and timer
    @objc func turnOnTheLight() {
        if let dev = device, dev.hasTorch {
            do {
                try dev.lockForConfiguration()
                dev.torchMode = AVCaptureDevice.TorchMode.on
                dev.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    // turn the flash on with flashbutton and timer
    @objc func turnOffTheLight() {
        if let dev = device, dev.hasTorch {
            do {
                try dev.lockForConfiguration()
                dev.torchMode = AVCaptureDevice.TorchMode.off
                dev.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
}
