//
//  CircleImage.swift
//  Smack
//
//  Created by Trinh Thai on 10/4/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView () {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}
