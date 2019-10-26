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
        setupUserInfo()
        ibTableView.delegate = self
        ibTableView.dataSource = self
        
        SocketService.instance.getChannel() { success in
            if success {
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
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            ibLoginButton.setTitle(UserDataService.instance.name, for: .normal)
            ibAvatarImg.image = UIImage(named: UserDataService.instance.avatarName)
            ibAvatarImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            
        } else {
            ibLoginButton.setTitle("Login", for: .normal)
            ibAvatarImg.image = UIImage(named: "menuProfileIcon")
            ibAvatarImg.backgroundColor = .clear
        }
    }
    
    @IBAction func ibAddChannelTapped(_ sender: Any) {
        let vc = AddChannelVC()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
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
}
