
//
//  RoundedButton.swift
//  Smack
//
//  Created by Trinh Thai on 10/2/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            //self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        setupButton()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
    
    func setupButton() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
