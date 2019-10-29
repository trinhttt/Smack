//
//  ProfileVC.swift
//  Smack
//
//  Created by Trinh Thai on 10/23/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var ibAvatar: UIImageView!
    @IBOutlet weak var ibName: UILabel!
    @IBOutlet weak var ibEmail: UILabel!
    @IBOutlet weak var ibBGView: UIView!
    @IBOutlet weak var ibNewNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func ibUpdateNameTapped(_ sender: Any) {
        guard let name = ibNewNameTF.text, name != "" else {
            return
        }
        AuthService.instance.updateUserName(newName: name) { (success) in
            if success {
                UserDataService.instance.setUserName(name: name)
                self.ibName.text = name
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    @IBAction func ibCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ibLogoutTapped(_ sender: Any) {
        UserDataService.instance.userLogout()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        ibName.text = UserDataService.instance.name
        ibEmail.text = UserDataService.instance.email
        ibAvatar.image = UIImage(named: UserDataService.instance.avatarName)
        ibAvatar.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
//        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeTapped(_:)))
//        self.ibBGView.addGestureRecognizer(closeTap)
    }
//    @objc func closeTapped(_ recognizer: UITapGestureRecognizer) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    
}
