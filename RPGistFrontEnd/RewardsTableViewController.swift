//
//  RewardsViewController.swift
//  RPGistFrontEnd
//
//  Created by Priscilla Jofani Oetomo on 9/21/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//

import UIKit

class RewardsTableViewController: UITableViewController {
    var currGold = 100 //just for testing
    var currLevel = 60 //just for testing
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var gold: UIBarButtonItem!
    
    @IBAction func storeBtnPressed(sender: AnyObject) {
        let storeAlert = UIAlertController(title: "Store", message: "Store coming soon!", preferredStyle: .alert)
        storeAlert.setValue(NSAttributedString(string: "Store", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        storeAlert.setValue(NSAttributedString(string: "Store coming soon!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = storeAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        storeAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        storeAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(storeAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
//        tblView.tableFooterView = UIView()
        
        tblView.accessibilityIdentifier = "RewardsTable"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        //I hard coded this thing, but this is where u should load from the database to set the amount of gold in the nav bar
        self.gold.title = String(currGold) + " g"
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
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
        
        cell.accessibilityIdentifier = "RewardsTableCell_\(indexPath.row)"
        
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
        cell.collectionView.reloadData() //this line of code needs to be here because as soon as the user unlocks a theme or profile picture, somehow it goes back to this function and it will have to reload the data so that we'll get rid of the lock layer (the grey layer on top of imageView)
        cell.collectionView.contentOffset = .zero //and this line of code also needs to be here so that the collectionView scrolls back to the first item after the user unlocks something
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
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    
                    cell.locked.text = "Level \(String(Model.get.profilePictureLevelReqs[indexPath.row] + 1))\n\n\(String(Model.get.profilePicturePrices[indexPath.row])) g"
                    
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
                    //*********************************************************//
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
        
        collectionView.accessibilityIdentifier = "RewardsCollection"
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
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            //Believe it or not, the whole code in this wall of comments is for an alert
            
            var canUnlock: Bool = false //This is a variable to show that the user has the requirements to unlock, it's only used to determine the button(s) that will show up on the alert
            var msg = "This item is locked!\n"
            if (collectionView.tag == 2 && self.currLevel < Model.get.profilePictureLevelReqs[indexPath.row]) {
                msg += "You need to at least be at level \(Model.get.profilePictureLevelReqs[indexPath.row] + 1) and have \(price) g to unlock."
            } else if (self.currGold < price) {
                msg += "You need to at least have \(price) g to unlock."
            } else {
                msg += "Spend \(price) g to unlock?"
                canUnlock = true
            }
            
            let alert = UIAlertController(title: "Unlock", message: msg, preferredStyle: .alert)
            alert.setValue(NSAttributedString(string: "Unlock", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
            alert.setValue(NSAttributedString(string: msg, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
            
            let subview1 = alert.view.subviews.first! as UIView
            let subview2 = subview1.subviews.first! as UIView
            let view = subview2.subviews.first! as UIView
            view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
            view.tintColor = Model.get.textColours[indexChosen.mainColour]
            alert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
            
            //And this is where that variable is used
            if (canUnlock) {
                //Two buttons (Yes and No) if they can unlock it
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action:UIAlertAction) in
                    self.currGold -= price
                    self.gold.title = String(self.currGold)
                    
                    switch collectionView.tag {
                    case 0:
                        Model.get.mainColourFlags[indexPath.row] = true
                    case 1:
                        Model.get.secondaryColourFlags[indexPath.row] = true
                    case 2:
                        Model.get.profilePictureFlags[indexPath.row] = true
                    default:
                        print("Error")
                    }
                    
                    self.tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel))
            } else {
                //And one button (OK) if they don't meet the requirement(s)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            }
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Confirmation", message: "Change current " + name + "?", preferredStyle: .alert)
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            //This is for the theme, don't worry about it too much
            
            alert.setValue(NSAttributedString(string: "Confirmation", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
            alert.setValue(NSAttributedString(string: "Change current " + name + "?", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
            
            let subview1 = alert.view.subviews.first! as UIView
            let subview2 = subview1.subviews.first! as UIView
            let view = subview2.subviews.first! as UIView
            view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
            view.tintColor = Model.get.textColours[indexChosen.mainColour]
            alert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                
                //Just in case u're confused, the name is set for which section you're in
                //It's probably better to change the switch option to collectionView.tag tbh, and put the cases as 0, 1 and 2 instead of strings
                switch name {
                    case "Main Theme Colour":
                        //This should be where u'll be saving the current main theme colour
                        
                        self.view?.backgroundColor = Model.get.mainColours[indexPath.row]
                        indexChosen.mainColour = indexPath.row
                    case "Secondary Theme Colour":
                        //This should be where u'll be saving the current secondary theme colour
                        
                        self.navigationController?.navigationBar.barTintColor = Model.get.secondaryColours[indexPath.row]
                        UINavigationBar.appearance().barTintColor = Model.get.secondaryColours[indexPath.row]
                        self.navigationController?.navigationBar.tintColor = Model.get.extraColours1[indexPath.row]
                        UINavigationBar.appearance().tintColor = Model.get.extraColours1[indexPath.row]
                        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Model.get.extraColours1[indexPath.row]]
                        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : Model.get.extraColours1[indexPath.row]]
                        
                        self.tabBarController?.tabBar.barTintColor = Model.get.secondaryColours[indexPath.row]
                        self.tabBarController?.tabBar.tintColor = Model.get.extraColours1[indexPath.row]
                    
                        indexChosen.secondaryColour = indexPath.row
                    case "Profile Picture":
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        
                        //I used to save the index of the profile picture, but I think it's better to actually save the name of the picture itself
                        //So this is also gonna be where u will be saving the picture to the database
                        
                        indexChosen.profilePicture = Model.get.profilePictures[indexPath.row]
                    
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                        //*********************************************************//
                    default:
                        break
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
