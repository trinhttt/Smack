//
//  ChatVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/15/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet weak var ibMenuBtn: UIButton!
    @IBOutlet weak var ibChannelName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ibMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (findSuccess) in
                if findSuccess{
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
    }
    
    @objc func userDataChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            ibChannelName.text = "Please login"
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        if let channelName = MessageService.instance.selectedChannel?.channelTitle {
            ibChannelName.text = "#\(channelName)"
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChanels { (success) in
            if success {
            }
        }
    }

}
