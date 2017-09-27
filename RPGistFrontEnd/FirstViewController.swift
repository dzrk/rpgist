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
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addCategory(sender: AnyObject) {
        let catAlert = UIAlertController(title: "New category", message: "Enter your category", preferredStyle: .alert)
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
        }))
        self.present(catAlert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.backgroundColor = Model.get.mainColourChosen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //swipe to remove
    func tableView(_ taskView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.categoryList[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
        //#85C7F2 baby blue
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

