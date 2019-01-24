//
//  Extensions.swift
//  Simproofn
//
//  Created by Hamzhya on 23/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
