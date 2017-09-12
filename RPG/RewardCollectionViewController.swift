//
//  RewardCollectionViewController.swift
//  RPG
//
//  Created by Derrick Phung on 27/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
class RewardCollectionViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var rewardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardCollectionView.delegate = self
        rewardCollectionView.dataSource = self
    }
    
    public func collectionView(_ rewardCollectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int{
        
        return Model.get.rewards.count
    } //counts items to be turned into cells
    
    public func collectionView(_ rewardCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = rewardCollectionView.dequeueReusableCell(withReuseIdentifier: "RewardCustomCell", for: indexPath) as! RewardCustomCell
        cell.layer.cornerRadius = 50
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        cell.rewardImages.image = UIImage(named: Model.get.rewards[indexPath.row])
        cell.rewardImages.contentMode = .scaleAspectFill
        return cell
    } //creates cell
    
    
    func collectionView(_ rewardCollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath)
        rewardCollectionView.deselectItem(at: indexPath, animated:true)
        //        varPassed.popupPassed = data!
        //        performSegue(withIdentifier: "CollectionToPopup", sender: cell)
        
        
        //        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }// method to run when table view cell is tapped
    
    
}
