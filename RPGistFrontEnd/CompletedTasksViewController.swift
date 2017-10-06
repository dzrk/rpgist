//
//  CompletedTasksViewController.swift
//  RPGistFrontEnd
//
//  Created by Priscilla Jofani Oetomo on 10/6/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//

import UIKit

class CompletedTasksViewController: UITableViewController {
    @IBOutlet weak var completedTaskView: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        self.completedTaskView.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        self.completedTaskView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.completedTaskView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        completedTaskView.delegate = self
        completedTaskView.dataSource = self
        completedTaskView.accessibilityIdentifier = "CompletedTaskViewTable"
    }
    
    override func tableView(_ completedTaskView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //do something
        }
    }
    
    // number of rows in table view
    override func tableView(_ completedTaskView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 //change this number!
    }
    
    // create a cell for each table view row
    override func tableView(_ completedTaskView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.completedTaskView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = ""
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        cell.textLabel?.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        
        //cell.backgroundColor = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
        cell.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        let backgroundView = UIView()
        //backgroundView.backgroundColor = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
        backgroundView.backgroundColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        //#85C7F2 baby blue
        
        cell.accessibilityIdentifier = "CompletedTasksViewCell_\(indexPath.row)"
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        cell.selectedBackgroundView = backgroundView
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        /*
         let cellLabel = UILabel()
         cellLabel.textAlignment = .right
         cellLabel.text = "Hi!"
         cellLabel.translatesAutoresizingMaskIntoConstraints = false
         
         cellLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
         cellLabel.heightAnchor.constraint(equalToConstant: cell.frame.height).isActive = true
         view.addConstraint(NSLayoutConstraint(item: cellLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 0.9, constant: 0))
         cellLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
         
         cell.addSubview(cellLabel)
         */
        
        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ completedTaskView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = completedTaskView.cellForRow(at: indexPath)
        completedTaskView.deselectRow(at: indexPath, animated:true)
        
        let data = (cell?.textLabel?.text)
        varPassed.catToTask = data!
        
        performSegue(withIdentifier: "FirstViewToTaskCont", sender: cell)
    }

}
