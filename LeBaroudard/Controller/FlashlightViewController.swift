//
//  FlashlightViewController.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 14/03/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.


//
// FlashlightViewController.
import UIKit
import AVFoundation

class FlashlightViewController: UIViewController {

    @IBOutlet weak var onOffTorchSwitch: UISwitch!
    @IBOutlet weak var onOffStrobSwitch: UISwitch!
    @IBOutlet weak var flashButton: ButtonFlash!
    @IBOutlet weak var slideStrob: UISlider!
    
    var timer: Timer?
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    var flashOn = false
    var IsFlashing = false
    var Switch = false
    
    let morse = Morse()
    let torch = Torch()
    let strob = Strob()
    
    
    // ===========    flash for MORSE mode  ======================
    // Flash button turn light and launch the timer - event button : touch on and touch up outside
    @IBAction func flashButtonDown(_ sender: AnyObject) {
        morse.turnOnTheLight()
        flashButton.backgroundColor = UIColor.white
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(repeatLight), userInfo: nil, repeats: true)
        flashButton.backgroundColor = UIColor.white
    }
     // flash button turn light ) envent button : touch up inside
    @IBAction func flashButtonUP(_ sender: AnyObject) {
        timer!.invalidate()
        //flashButton.backgroundColor = UIColor.black
        morse.turnOffTheLight()
    }
    
    // repeat light for flashButton down
    @objc func repeatLight() {
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
    
    // ===========    TORCH  mode   ======================
    // launch the change of state
    @IBAction func switchTorch(_ sender: Any) {
             torch.switchLight()
    }
     // set the level of intensity from the slider
    @IBAction func switchStrob(_ sender: Any) {
        if(IsFlashing) {
            timer!.invalidate()
            IsFlashing = false
        } else {
            IsFlashing = true
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.50), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            strob.setflashOff()
        }
    }
    // set the level of frequency from the slider
    @IBAction func frequencyStrobChange(_ sender: UISlider) {
        if(IsFlashing)
        {
            let frequency = sender.value
            print("slide")
            timer!.invalidate()
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(frequency), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        else
        {
            timer!.invalidate()
        }
    }
     // set the level of intensity from the slider
    @IBAction func levelTorchSlide(_ sender: UISlider) {
        if let dev = device {
            do {
                try dev.lockForConfiguration()
                let intensity = sender.value
                try dev.setTorchModeOn(level: Float(intensity))
                dev.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    // launch the alternate state from the selector
    @objc func fireTimer() {
        strob.toggleTorch(on: Switch)
        Switch = !Switch
    }
}






