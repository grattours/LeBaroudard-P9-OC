//
//  Strob.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 03/04/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import AVFoundation
import Foundation

class Strob {
    
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    
    // switch the flash on/off
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("La torche n'est pas utilisable")
            }
        } else {
            print("La torche est indisponible")
        }
    }
    
    // set the flash On
    @objc func setflashOn() {
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
    
    // set the flash Off
    func setflashOff() {
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
