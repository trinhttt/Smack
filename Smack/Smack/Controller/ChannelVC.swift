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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    
    @IBAction func ibLoginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_LOGIN , sender: nil)
    }
    
    @IBAction func prepareForUnwind(sugue: UIStoryboardSegue){}
    
    @objc func userDataDidChange(_ notif: Notification) {
        
    }

}
