//
//  ChatVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/15/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ibMenuBtn: UIButton!
    @IBOutlet weak var ibChannelName: UILabel!
    @IBOutlet weak var ibMessageTextBox: UITextField!
    @IBOutlet weak var ibTableView: UITableView!
    @IBOutlet weak var ibSendButton: UIButton!
    
    //MARK: - Variables
    var isTyping: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        ibTableView.delegate = self
        ibTableView.dataSource = self
        ibSendButton.isHidden = true
//        ibTableView.rowHeight = UITableView.automaticDimension
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
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
        
        SocketService.instance.getChatMessage { (success) in
            if success {
                self.ibTableView.reloadData()
                
                //scroll to bottom
                let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                self.ibTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
    }
    
    @objc func userDataChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            ibChannelName.text = "Please login"
            ibTableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        if let channelName = MessageService.instance.selectedChannel?.channelTitle {
            ibChannelName.text = "#\(channelName)"
        } else {
            ibChannelName.text = ""
        }
         getMessages()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChanels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]//default
                    self.updateWithChannel()
                } else {
                    self.ibChannelName.text = "No channels yet"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            if success {
                self.ibTableView.reloadData()
            }
        }
    }
    
    @IBAction func ibMessBoxEditing(_ sender: Any) {
        if ibMessageTextBox.text == "" {
            isTyping = false
            ibSendButton.isHidden = true
        } else {
            if isTyping == false {
                ibSendButton.isHidden = false
            }
            isTyping = true
        }
    }
    
    
    @IBAction func sendMessageTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let mess = ibMessageTextBox.text else { return }
            SocketService.instance.addMessage(messBody: mess, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.ibMessageTextBox.text = ""
                    self.ibMessageTextBox.resignFirstResponder()
                }
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }

}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(mess: message)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
