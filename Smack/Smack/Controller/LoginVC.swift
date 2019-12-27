//
//  LoginVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/21/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var ibUsername: ColorPlaceholderTextField!
    @IBOutlet weak var ibPassword: ColorPlaceholderTextField!
    @IBOutlet weak var ibSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBAction func ibClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ibCreateAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func ibLoginTapped(_ sender: Any) {
        ibSpinner.isHidden = false
        ibSpinner.startAnimating()
        guard let email = ibUsername.text, let password = ibPassword.text else {
            return
        }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            self.ibSpinner.isHidden = true
            self.ibSpinner.stopAnimating()
            if success {
                AuthService.instance.findUserByEmail(completion: { (findSuccess) in
                    if findSuccess{
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                })
            } else {
                let alert = UIAlertController(title: "Error", message: "The email or password is incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        ibSpinner.isHidden = true
    }
}
