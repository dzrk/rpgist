//
//  RewardsViewController.swift
//  RPGistFrontEnd
//
//  Created by Priscilla Jofani Oetomo on 9/21/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//

import UIKit

class RewardsTableViewController: UITableViewController {
    @IBOutlet weak var tblView: UITableView!
    
    fileprivate var tableViewCellCoordinator: [IndexPath: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! RewardsTableViewCellController
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        let tag = 10000 * (indexPath.section + 1) + indexPath.row
        cell.collectionView.tag = tag
        tableViewCellCoordinator[indexPath] = tag
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var name: String
        
        switch section {
            case 0:
                name = "Main Theme Colour"
            case 1:
                name = "Secondary Theme Colour"
            case 2:
                name = "Profile Picture"
            default:
                name = "Section: \(section)"
        }
        
        return name
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! RewardsTableViewCellController
        cell.collectionView.reloadData()
        cell.collectionView.contentOffset = .zero
    }

}

// UICollectionViewDataSource

extension RewardsTableViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! RewardsCollectionViewCellController
        return cell
    }
}

// UICollectionViewDelegate

extension RewardsTableViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! RewardsCollectionViewCellController
        //cell.label.text = "\(tableViewCellCoordinator.key(forValue: collectionView.tag)!) \(indexPath)"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("selected collectionViewCell with indexPath: \(indexPath) in tableViewCell with indexPath: \(tableViewCellCoordinator.key(forValue: collectionView.tag)!)")
    }
    
}
