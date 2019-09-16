//
//  ChatVC.swift
//  Smack
//
//  Created by Trinh Thai on 9/15/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet weak var ibMenuBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ibMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }

}
