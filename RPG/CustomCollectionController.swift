//
//  CustomCollectionController.swift
//  RPG
//
//  Created by Derrick Phung on 26/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
class CustomCollectionController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView:UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int{
        
        return Model.get.images.count
    } //counts items to be turned into cells
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.layer.cornerRadius = 50
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 3
        cell.myImage.image = UIImage(named: Model.get.images[indexPath.row])
        cell.myImage.contentMode = .scaleAspectFill
        return cell
    } //creates cell
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated:true)
//        varPassed.popupPassed = data!
//        performSegue(withIdentifier: "CollectionToPopup", sender: cell)

        
//        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }// method to run when table view cell is tapped
    
    
}

