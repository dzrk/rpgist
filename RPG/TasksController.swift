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

//    let cellReuseIdentifier = "cell"
    let cellChosen = varPassed.catToTask
    var chosenList: [String] = []
    var dbRef:DatabaseReference!
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var taskView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child(varPassed.uid)
        startObservingDB()
        // Register the table view cell class and its reuse id
//        self.taskView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        taskView.accessibilityIdentifier = "TasksTable"
        // This view controller itself will provide the delegate methods and row data for the table view.
        taskView.delegate = self
        taskView.dataSource = self
        self.title = cellChosen
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.taskView.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.addBtn.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.addBtn.setTitleColor(Model.get.textColours[indexChosen.mainColour], for: .normal)
        self.taskView.reloadData()

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
        // themes chosen by user
        taskAlert.setValue(NSAttributedString(string: "New Task", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        taskAlert.setValue(NSAttributedString(string: "Enter your task name", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = taskAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        taskAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
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
        taskAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // number of rows in table view
    func tableView(_ taskView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tasks.count
        case 1:
            return 2 //change this number
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Not Completed"
        case 1:
            return "Completed"
        default:
            return "Error!"
        }
    }

    
    // create a cell for each table view row
    func tableView(_ taskView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = self.taskView.dequeueReusableCell(withIdentifier: "TaskViewCell") as! TasksViewCellController

        // set the text from the data model

        // create a new cell if needed or reuse an old one
        
        switch indexPath.section {
        case 0:
            // set the text from the data model
            if tasks[indexPath.row].cat == cellChosen{
                cell.taskName.text = tasks[indexPath.row].name
            }
            cell.taskName.textColor = Model.get.textColours[indexChosen.mainColour]
            cell.taskDetailsLbl.text = "1 exp, 1 g"
            cell.taskDetailsLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            cell.checkImg.image = UIImage(named: "first")?.withRenderingMode(.alwaysTemplate)
            cell.checkImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
            cell.accessibilityIdentifier = "TasksCell_\(indexPath.row)"
        case 1:
            // set the text from the data model
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Completed Task " + String(indexPath.row + 1))
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.taskName.attributedText = attributeString
            cell.taskName.textColor = Model.get.textColours[indexChosen.mainColour].withAlphaComponent(0.3)
            cell.taskDetailsLbl.text = "0 exp, 0 g"
            cell.taskDetailsLbl.textColor = Model.get.textColours[indexChosen.mainColour].withAlphaComponent(0.3)
            cell.checkImg.image = UIImage(named: "second")?.withRenderingMode(.alwaysTemplate)
            cell.checkImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
            cell.accessibilityIdentifier = "CompletedTasksCell_\(indexPath.row)"
        default:
            cell.taskName.text = "Error!"
        }
        
        //cell.backgroundColor = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
        cell.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        let backgroundView = UIView()
        //backgroundView.backgroundColor = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
        backgroundView.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        
        
        cell.selectedBackgroundView = backgroundView
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ taskView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = taskView.cellForRow(at: indexPath) as! TasksViewCellController
        taskView.deselectRow(at: indexPath, animated:true)
        
        let data = (cell.taskName.text)
        varPassed.taskToInfo = data!
        
        performSegue(withIdentifier: "TasksToCustom", sender: cell)
        
    }

}
