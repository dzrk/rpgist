//
//  FirstViewController.swift
//  RPGistFrontEnd
//
//  Created by Priscilla Jofani Oetomo on 9/14/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//

import UIKit
struct varPassed {
    static var catToTask = ""
    static var taskToInfo = ""
    static var popupPassed = ""
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // collectionview > table > table? this is the first table view for tasks
    // Data model: These strings will be the data for the table view cells
    let categoryList: [String] = ["School", "Work", "Personal", "Shopping"]
    var test: String?
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addCategory(sender: AnyObject) {
        let catAlert = UIAlertController(title: "New category", message: "Enter your category", preferredStyle: .alert)
        
        catAlert.setValue(NSAttributedString(string: "New Category", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        catAlert.setValue(NSAttributedString(string: "Enter your category", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = catAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        catAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        catAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "New category name"
        }
        
        catAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action:UIAlertAction) in
//            if let catContent = catAlert.textFields?.first?.text {
//                let cat = String(catContent)
//                
//                let catRef = self.dbRef.child("category").child(catContent)
//                
//                catRef.setValue(cat)
//                
//            }
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            //Checking if the same task name has already existed in the category
            
            var i = 0
            
            repeat {
                if (catAlert.textFields![0].text?.caseInsensitiveCompare(self.categoryList[i]) == .orderedSame) {
                    self.unsuccessfulInput()
                    break
                }
                i += 1
            } while (i < self.categoryList.count)
            
            if (i == self.categoryList.count) {
                self.successInput()
            }
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
        }))
        
        catAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(catAlert, animated: true, completion: nil)
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    func unsuccessfulInput() {
        let validationAlert = UIAlertController(title: "Not Allowed", message: "You already have this category name!", preferredStyle: .alert)
        validationAlert.setValue(NSAttributedString(string: "Not Allowed", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        validationAlert.setValue(NSAttributedString(string: "You already have this category name!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = validationAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        validationAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        validationAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(validationAlert, animated: true, completion: nil)
    }
    
    func successInput() {
        let successAlert = UIAlertController(title: "Success", message: "Successfully added category!", preferredStyle: .alert)
        successAlert.setValue(NSAttributedString(string: "Success", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        successAlert.setValue(NSAttributedString(string: "Successfully added category!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = successAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        successAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        successAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(successAlert, animated: true, completion: nil)
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        
        self.addBtn.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.addBtn.setTitleColor(Model.get.textColours[indexChosen.mainColour], for: .normal)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.accessibilityIdentifier = "FirstViewTable"
    }
    
    //swipe to remove
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //do something
        }
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryList.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FirstViewCell") as! FirstViewCellController
        
        // set the text from the data model
        cell.textLabel?.text = self.categoryList[indexPath.row]
        cell.textLabel?.textColor = Model.get.textColours[indexChosen.mainColour]
        
        //cell.backgroundColor = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
        cell.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        let backgroundView = UIView()
        //backgroundView.backgroundColor = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
        backgroundView.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        //#85C7F2 baby blue
        
        cell.accessibilityIdentifier = "FirstViewCell_\(indexPath.row)"
        cell.selectedBackgroundView = backgroundView
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated:true)
        
        let data = (cell?.textLabel?.text)
        varPassed.catToTask = data!
        
        performSegue(withIdentifier: "FirstViewToTaskCont", sender: cell)
    }
}

