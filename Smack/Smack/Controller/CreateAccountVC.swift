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
    
    @IBOutlet weak var ibSpinner: UIActivityIndicatorView!
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
//    var colorArr: [UIColor] = [.lightGray, .red, .green, .blue, .orange, .yellow, .purple]
//    var colorBGIndex = -1 {
//        didSet {
//            if colorBGIndex > colorArr.count - 1{
//                colorBGIndex = 0
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            avatarName = UserDataService.instance.avatarName
            ibAvatarImg.image = UIImage(named: avatarName)
            if avatarName.contains("light") && bgColor == nil{
                ibAvatarImg.backgroundColor = .lightGray
            }
        }
    }
    
    @IBAction func ibCreateAccountTapped(_ sender: Any) {
        ibSpinner.isHidden = false
        ibSpinner.startAnimating()
        
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
                                self.ibSpinner.isHidden = true
                                self.ibSpinner.stopAnimating()
                                print(UserDataService.instance.name)
                                print(UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
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
        /// User color array:
        //        colorBGIndex += 1
        //        ibAvatarImg.backgroundColor = colorArr[colorBGIndex]
        
        /// Random color: number/255
        let red = CGFloat.random(in: 0.0...1.0)
        let green = CGFloat.random(in: 0.0...1.0)
        let blue = CGFloat.random(in: 0.0...1.0)
        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        avatarColor = "[\(red),\(green),\(blue),1]"
        UIView.animate(withDuration: 0.2) {
            self.ibAvatarImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func ibCloseTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setupView() {
        ibSpinner.isHidden = true
//        let tap = UIGestureRecognizer(target: self, action: #selector(handleTap))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
}
