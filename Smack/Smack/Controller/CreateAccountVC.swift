//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/21/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // Outlets
  
    @IBOutlet weak var ibUsernameTxt: UITextField!
    @IBOutlet weak var ibEmailTxt: UITextField!
    @IBOutlet weak var ibPasswordTxt: UITextField!
    @IBOutlet weak var ibAvatarImg: UIImageView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            avatarName = UserDataService.instance.avatarName
            ibAvatarImg.image = UIImage(named: avatarName)
        }
    }
    
    @IBAction func ibCreateAccountTapped(_ sender: Any) {
        
        guard let name = ibUsernameTxt.text, ibUsernameTxt.text != "" else {
            return
        }
        guard let email = ibEmailTxt.text, ibEmailTxt.text != "" else {
            return
        }
        guard let password = ibPasswordTxt.text, ibPasswordTxt.text != "" else {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("registered user")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("logged in user with token: \(AuthService.instance.authToken)")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name)
                                print(UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    } else {
                        print("log in fail")
                    }
                })
            } else{
                print("register user fail")
            }
        }
    }
    
    @IBAction func ibPickAvatarTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func ibPickBGColorTapped(_ sender: Any) {
    }
    
    @IBAction func ibCloseTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
