//
//  TasksController.swift
//  RPG
//
//  Created by Derrick Phung on 17/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TasksController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let schoolList: [String] = ["Study for iPhone", "Study for Capstone", "Study for C++"]
    let workList: [String] = ["Finish the days report", "Prepare for meeting", "Exercise at lunch"]
    let personalList: [String] = ["Salad for dinner", "Haircut", "Go to the gym"]
    let shoppingList: [String] = ["Eggs", "Milk", "Bread"]
    
    let cellReuseIdentifier = "cell"
    let cellChosen = varPassed.catToTask
    var chosenList: [String] = []
    var dbRef:DatabaseReference!
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var taskView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child(varPassed.uid)
        startObservingDB()
        // Register the table view cell class and its reuse id
        self.taskView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        taskView.delegate = self
        taskView.dataSource = self
        self.title = cellChosen
    }
    
    func startObservingDB (){
        //        let userID = Auth.auth().currentUser?.uid
        
        dbRef.child("task").observe(.value, with: { (snapshot:DataSnapshot) in
            var newTasks = [Task]()
            
            for item in snapshot.children {
                let taskObject = Task(snapshot: item as! DataSnapshot)
                if taskObject.cat == self.cellChosen{
                    newTasks.append(taskObject)
                }
            }
            
            tasks = newTasks
            
            self.taskView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addTask(sender: AnyObject) {
        let taskAlert = UIAlertController(title: "New task", message: "Enter your task name", preferredStyle: .alert)
        taskAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "New task name"
        }
        taskAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action:UIAlertAction) in
            if let taskContent = taskAlert.textFields?.first?.text {
                let task = String(taskContent)
                let ref = self.dbRef.child("task").child(taskContent)
                let taskRef = ref.child("name")
                let catRef = ref.child("cat")
                let compRef = ref.child("completed")
                taskRef.setValue(task)
                catRef.setValue(self.cellChosen)
                compRef.setValue(false)
                
            }
        }))
        self.present(taskAlert, animated: true, completion: nil)
        
        
    }
    //swipe to remove task
    func tableView(_ taskView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
              let task = tasks[indexPath.row]
        
              task.itemRef?.removeValue()
        }
    }

    func tableView(_ taskView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }

    // number of rows in table view
    func tableView(_ taskView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count

    }
    
    // create a cell for each table view row
    func tableView(_ taskView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.taskView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        // set the text from the data model
        if tasks[indexPath.row].cat == cellChosen{
            cell.textLabel?.text = tasks[indexPath.row].name
        }
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
    func tableView(_ taskView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = taskView.cellForRow(at: indexPath)
        taskView.deselectRow(at: indexPath, animated:true)
        
        let data = (cell?.textLabel?.text)
        varPassed.taskToInfo = data!
        
        performSegue(withIdentifier: "TasksToCustom", sender: cell)
        
    }

}
