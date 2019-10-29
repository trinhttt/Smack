//
//  ChannelCell.swift
//  Smack
//
//  Created by Trinh Thai on 10/24/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var ibChannelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        if let name = channel.channelTitle {
            self.ibChannelName.text = "#\(name)"
        }else {
            self.ibChannelName.text = ""
        }
        self.ibChannelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)

        for id in MessageService.instance.unreadChannelIds {
            if channel.id == id{
                self.ibChannelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }

}
