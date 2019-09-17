//
//  GradientView.swift
//  Smack
//
//  Created by Trinh Thai on 9/16/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    let gradientLayer = CAGradientLayer()

    @IBInspectable var startColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
        //gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        self.setNeedsLayout()
        }
    }
    
    @IBInspectable var endColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1)  {
        didSet {
        //gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        self.setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {

        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
