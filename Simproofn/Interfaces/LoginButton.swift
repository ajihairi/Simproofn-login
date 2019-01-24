//
//  LoginButton.swift
//  Simproofn
//
//  Created by Hamzhya on 23/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import Foundation
import UIKit

let kLoginButtonBackgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
let kLoginButtonTintColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha:1.0)
let kLoginButtonCornerRadius: CGFloat = 10.0

class LoginButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = kLoginButtonBackgroundColor
        self.layer.cornerRadius = kLoginButtonCornerRadius
        self.tintColor = kLoginButtonTintColor
    }
    
}
