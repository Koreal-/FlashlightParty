//
//  ViewController.swift
//  Flashlight
//
//  Created by Kartinin Studio on 08.12.2020.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    //MARK: - PROPERTIES
    var stopParty = Bool()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to screen for Party Light"
        label.font = UIFont(name: "Avenir-Light", size: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    private let lightButtonStop: StandartButton = {
        let button = StandartButton(type: .system)
        button.setTitle("STOP LIGHT BUTTON", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleStopLight), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //one tap to start
        let tap = UITapGestureRecognizer(target: self, action: #selector(Tapped))
            tap.numberOfTapsRequired = 1
            view.addGestureRecognizer(tap)
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.anchor(top: view.topAnchor, paddingTop: 40)
        
        view.addSubview(lightButtonStop)
        lightButtonStop.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lightButtonStop.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lightButtonStop.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
    }
    
    //MARK:- HELPER FUNCTIONS
    
    func partyLight() {
        titleLabel.alpha = 0
        toggleFlash()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if self!.stopParty == true {
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self!.view.backgroundColor = .random()
                    self!.view.alpha = 1
                    self!.partyLight()
                })
                
            }
            
        }
        
    }
    
    func toggleFlash() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if ((device?.hasTorch) != nil) {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureDevice.TorchMode.on) {
                    device?.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device?.setTorchModeOn(level: 1.0)
                    } catch {
                        print(error)
                    }
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - SELECTOR
    @objc func Tapped() {
        stopParty = false
        partyLight()

    }
    
    @objc func handleStopLight() {
        stopParty = true
        partyLight()
        titleLabel.alpha = 1
        self.view.backgroundColor = .white
    }


}

//MARK: EXTENSIONS
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
