//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Trinh Thai on 10/3/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

    // Outlets
    @IBOutlet weak var ibCollectionView: UICollectionView!
    
    @IBOutlet weak var ibSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibCollectionView.delegate = self
        ibCollectionView.dataSource = self
    }

    @IBAction func ibSegmentControlChanged(_ sender: Any) {
    }
    
    
    @IBAction func ibBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AvatarPickerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            return cell
        }
        return AvatarCell()
    }
    
    
}
