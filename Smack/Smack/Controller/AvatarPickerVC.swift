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
    
    //Variables
    var avatarType: AvatarType = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibCollectionView.delegate = self
        ibCollectionView.dataSource = self
    }

    @IBAction func ibSegmentControlChanged(_ sender: Any) {
        if ibSegmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        ibCollectionView.reloadData()
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
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumns: CGFloat = 3 //iphone SE
        if UIScreen.main.bounds.size.width > 300 {
            numberOfColumns = 4
        }
        let spacingBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        
        let size = (collectionView.bounds.size.width - padding - (numberOfColumns - 1) * spacingBetweenCells) / numberOfColumns
        
        return CGSize(width: size, height: size)
    }
    
    
}
