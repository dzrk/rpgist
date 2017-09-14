//
//  SecondViewController.swift
//  RPG
//
//  Created by Derrick Phung on 15/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let cellReuseIdentifier = "id.my.cell.skills"
    @IBOutlet weak var skillTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////        self.skillsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        skillTableView.delegate = self
        skillTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ skillTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.get.skills.count
    }
    
    // create a cell for each table view row
    func tableView(_ skillTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.skillTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        // set the text from the data model
        cell.textLabel?.text = Model.get.skills[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
        //#85C7F2 baby blue
        cell.selectedBackgroundView = backgroundView
        
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ skillTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = skillsTableView.cellForRow(at: indexPath)
        skillTableView.deselectRow(at: indexPath, animated:true)
        //
        //        let data = (cell?.textLabel?.text)
        //        varPassed.taskToInfo = data!
        //
        //        performSegue(withIdentifier: "TasksToCustom", sender: cell)
        
    }
    
    
    
}

