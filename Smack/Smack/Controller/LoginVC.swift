//
//  LoginVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/21/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func ibClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ibCreateAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants().TO_CREATE_ACCOUNT, sender: nil)
    }
    
}
