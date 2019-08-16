//
//  UIView + Extension.swift
//  Train-App
//
//  Created by Vicki Larkin on 20/07/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func applyShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.2
    }
    
}
