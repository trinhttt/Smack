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
        
        guard let isoDate = mess.timeStamp else {
            return
        }
        let finalDate = convertDate(isoDate: isoDate)
        ibTimeStamp.text = finalDate
    }
    
    func convertDate(isoDate: String) -> String {
        //2019-10-27T16:44:07.809Z
        let endIndex = isoDate.index(isoDate.endIndex, offsetBy: -5)//con tro tu cuoi qua 5 ky tu
        let date = isoDate[..<endIndex] //2019-10-27T16:44:07.809Z
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: date.appending("Z"))//2019-10-27 16:44:07 +0000
        
        let newFormater = DateFormatter()
        newFormater.dateFormat = "MMM d, h:mm a"
        
        if let chatDate = chatDate {
            return newFormater.string(from: chatDate)//Oct 27, 11:44 PM
        } else {
            return ""
        }
    }
}
