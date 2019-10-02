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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func ibCreateAccountTapped(_ sender: Any) {
        
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
    }
    
    @IBAction func ibPickBGColorTapped(_ sender: Any) {
    }
    

}
