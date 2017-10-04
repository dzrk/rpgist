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
    @IBOutlet weak var gold: UIBarButtonItem!
    
    fileprivate var tableViewCellCoordinator: [IndexPath: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.tableFooterView = UIView()
        
        gold.title = String(HeroViewController.get.currGold) + " g"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
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
        
        cell.collectionView.tag = indexPath.section
        
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
        switch collectionView.tag {
            case 0:
                return Model.get.mainColours.count
            case 1:
                return Model.get.secondaryColours.count
            case 2:
                return Model.get.profilePictures.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! RewardsCollectionViewCellController
        
        switch collectionView.tag {
            case 0:
                cell.backgroundColor = Model.get.mainColours[indexPath.row]
            
                if (Model.get.mainColourFlags[indexPath.row]) {
                    cell.locked.isHidden = true
                } else {
                    cell.locked.text = String(Model.get.mainColourPrices[indexPath.row]) + " g"
                }
            case 1:
                cell.backgroundColor = Model.get.secondaryColours[indexPath.row]
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.lightGray.cgColor
            
                if (Model.get.secondaryColourFlags[indexPath.row]) {
                    cell.locked.isHidden = true
                } else {
                    cell.locked.text = String(Model.get.secondaryColourPrices[indexPath.row]) + " g"
                }
            case 2:
                cell.backgroundColor = collectionView.backgroundColor
                cell.profilePicImages.image = UIImage(named: Model.get.profilePictures[indexPath.row])
                cell.profilePicImages.contentMode = .scaleAspectFill
            
                if (Model.get.profilePictureFlags[indexPath.row]) {
                    cell.locked.isHidden = true
                } else {
                    cell.locked.text = String(Model.get.profilePicturePrices[indexPath.row]) + " g"
                }
            default:
                cell.backgroundColor = cell.backgroundColor
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.lightGray
        cell.selectedBackgroundView = backgroundView
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
}

// UICollectionViewDelegate

extension RewardsTableViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _ = cell as! RewardsCollectionViewCellController
        //cell.label.text = "\(tableViewCellCoordinator.key(forValue: collectionView.tag)!) \(indexPath)"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated:true)
        
        var locked:Bool = false
        var price:Int = 0
        var name:String = ""
        
        switch collectionView.tag {
            case 0:
                if (!Model.get.mainColourFlags[indexPath.row]) {
                    locked = true
                    price = Model.get.mainColourPrices[indexPath.row]
                }
                
                name = "Main Theme Colour"
            case 1:
                if (!Model.get.secondaryColourFlags[indexPath.row]) {
                    locked = true
                    price = Model.get.secondaryColourPrices[indexPath.row]
                }
            
                name = "Secondary Theme Colour"
            case 2:
                if (!Model.get.profilePictureFlags[indexPath.row]) {
                    locked = true
                    price = Model.get.profilePicturePrices[indexPath.row]
                }
            
                name = "Profile Picture"
            default:
                locked = true
        }
        
        if (locked) {
            let alert = UIAlertController(title: "Unlock", message: "This item is locked!\nSpend " + String(price) + " g to unlock?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action:UIAlertAction) in
                // Do something
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action:UIAlertAction) in
                // Do something
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Confirmation", message: "Change current " + name + "?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action:UIAlertAction) in
                switch name {
                    case "Main Theme Colour":
                        //self.navigationController?.navigationBar.tintColor = Model.get.mainColours[indexPath.row]
                        self.view?.backgroundColor = Model.get.mainColours[indexPath.row]
                        
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        
                        Model.get.mainColourChosenIndex = indexPath.row
                    
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                    
                    case "Secondary Theme Colour":
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                        self.navigationController?.navigationBar.barTintColor = Model.get.secondaryColours[indexPath.row]
                        UINavigationBar.appearance().barTintColor = Model.get.secondaryColours[indexPath.row]
                        self.navigationController?.navigationBar.tintColor = Model.get.extraColours1[indexPath.row]
                        UINavigationBar.appearance().tintColor = Model.get.extraColours1[indexPath.row]
                        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Model.get.extraColours1[indexPath.row]]
                        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : Model.get.extraColours1[indexPath.row]]
                        
                        self.tabBarController?.tabBar.barTintColor = Model.get.secondaryColours[indexPath.row]
                        self.tabBarController?.tabBar.tintColor = Model.get.extraColours1[indexPath.row]
                    
                        Model.get.secondaryColourChosenIndex = indexPath.row
                    
                    case "Profile Picture":
                        Model.get.profilePictureChosenIndex = indexPath.row
                    
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    
                    default:
                        break
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action:UIAlertAction) in
                // Do something
            }))
            self.present(alert, animated: true, completion: nil)
        }

        
        //print("selected collectionViewCell with indexPath: \(indexPath) in tableViewCell with indexPath: \(tableViewCellCoordinator.key(forValue: collectionView.tag)!)")
    }
    
}
