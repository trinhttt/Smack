//
//  AvatarCell.swift
//  Smack
//
//  Created by Trinh Thai on 10/3/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {

    @IBOutlet weak var ibAvatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            self.ibAvatarImage.image = UIImage(named: "dark\(index)")
            self.backgroundColor = .lightGray
        } else {
            self.ibAvatarImage.image = UIImage(named: "light\(index)")
            self.backgroundColor = .gray
        }
    }
    
    func setupView() {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
