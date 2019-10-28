//
//  MessageCell.swift
//  Smack
//
//  Created by Trinh Thai on 10/28/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var ibUserImage: UIImageView!
    
    @IBOutlet weak var ibUserName: UILabel!
    @IBOutlet weak var ibTimeStamp: UILabel!
    @IBOutlet weak var ibMessageBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(mess: Message) {
        ibMessageBody.text = mess.message
        ibUserName.text = mess.userName
        ibUserImage.image = UIImage(named: mess.userAvatar)
        ibUserImage.backgroundColor = UserDataService.instance.returnUIColor(components: mess.userAvatarColor)
        
    }
    

}
