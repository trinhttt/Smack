//
//  ColorPlaceholderTextField.swift
//  Smack
//
//  Created by Trinh Thai on 10/4/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import Foundation

@IBDesignable
class ColorPlaceholderTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes:[ NSAttributedString.Key.foregroundColor: smackBluePlaceholder])
    }
}
