//
//  AddChannelVC.swift
//  Smack
//
//  Created by Trinh Thai on 10/25/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var ibName: ColorPlaceholderTextField!
    @IBOutlet weak var ibDescription: ColorPlaceholderTextField!
    @IBOutlet weak var ibBGView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBAction func ibCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ibAddChannelTapped(_ sender: Any) {
        guard let name = ibName.text, name != "" else {
            return
        }
        guard let description = ibDescription.text, description != "" else {
            return
        }
        SocketService.instance.addChannel(name: name, description: description) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        ibBGView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
