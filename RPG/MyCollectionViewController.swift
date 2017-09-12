//
//  DescriptionCollectionViewController.swift
//  RPG
//
//  Created by Derrick Phung on 26/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit

class MyCollectionViewController: UICollectionViewController {
    let reuseIdentifier = "id.my.cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.get.taskMenu.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        //cell.lblText!.text = Model.get.taskMenu[indexPath.row];
        return cell
    }
}
