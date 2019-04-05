//
//  Torch.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 03/04/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit
import AVFoundation

class Torch {
    
    var flashOn = false
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    // switch from one state to the other (ON/OFF)
    func switchLight() {
        if let dev = device, dev.hasTorch {
            do {
                try dev.lockForConfiguration()
                if (dev.torchMode == AVCaptureDevice.TorchMode.on) {
                    dev.torchMode = AVCaptureDevice.TorchMode.off
                    flashOn = false
                } else {
                    do {
                        try dev.setTorchModeOn(level: 1.0)
                        flashOn = true
                    } catch {
                        print(error)
                    }
                }
                dev.unlockForConfiguration()
            } catch {
                print(error)
            }
        } else {
            print("Alerte: pas de torche")
        }
    }
}
