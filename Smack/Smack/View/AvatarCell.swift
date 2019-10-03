//
//  AvatarCell.swift
//  Smack
//
//  Created by Trinh Thai on 10/3/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {

    @IBOutlet weak var ibAvatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
