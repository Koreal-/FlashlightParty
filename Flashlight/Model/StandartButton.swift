//
//  StandartButton.swift
//  Flashlight
//
//  Created by Kartinin Studio on 08.12.2020.
//

import UIKit

class StandartButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.systemBlue
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel?.textColor = .white
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
