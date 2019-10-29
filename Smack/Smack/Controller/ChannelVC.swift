//
//  ChannelVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/15/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var ibLoginButton: UIButton!
    @IBOutlet weak var ibAvatarImg: CircleImage!
    @IBOutlet weak var ibTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        setupUserInfo()
        ibTableView.delegate = self
        ibTableView.dataSource = self
        
        SocketService.instance.getChannel() { success in
            if success {
                self.ibTableView.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannelIds.append(newMessage.channelId)
                self.ibTableView.reloadData()
            }
        }
    }
    
    
    @IBAction func ibLoginButtonPressed(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn {
            let vc = ProfileVC()
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN , sender: nil)
        }
    }
    
    @IBAction func prepareForUnwind(sugue: UIStoryboardSegue){}
    
    @objc func userDataDidChange(_ notif: Notification) {
       // print(notif.userInfo)
       setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notifi: Notification) {
        ibTableView.reloadData()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            ibLoginButton.setTitle(UserDataService.instance.name, for: .normal)
            ibAvatarImg.image = UIImage(named: UserDataService.instance.avatarName)
            ibAvatarImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            
        } else {
            ibLoginButton.setTitle("Login", for: .normal)
            ibAvatarImg.image = UIImage(named: "menuProfileIcon")
            ibAvatarImg.backgroundColor = .clear
            ibTableView.reloadData()
        }
    }
    
    @IBAction func ibAddChannelTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let vc = AddChannelVC()
            vc.modalPresentationStyle = .custom
            present(vc, animated: true)
        }
    }
    

}

extension ChannelVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return  UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannelIds.count > 0 {
            MessageService.instance.unreadChannelIds = MessageService.instance.unreadChannelIds.filter{ $0 != channel.id}
            let index = IndexPath(row: indexPath.row, section: 0)
            tableView.reloadRows(at: [index], with: .none)
            tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        }
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
}
