//
//  TasksController.swift
//  RPG
//
//  Created by Derrick Phung on 17/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit

class TasksController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let schoolList: [String] = ["Study for iPhone", "Study for Capstone", "Study for C++"]
    let workList: [String] = ["Finish the days report", "Prepare for meeting", "Exercise at lunch"]
    let personalList: [String] = ["Salad for dinner", "Haircut", "Go to the gym"]
    let shoppingList: [String] = ["Eggs", "Milk", "Bread"]
    
    let cellChosen = varPassed.catToTask
    var chosenList: [String] = []
    var arr: [String] = ["one", "two"] //just for testing
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var taskView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        taskView.delegate = self
        taskView.dataSource = self
        self.title = cellChosen
        switch cellChosen {
        case "School":
            chosenList = schoolList
        case "Work":
            chosenList = workList
        case "Personal":
            chosenList = personalList
        case "Shopping":
            chosenList = shoppingList
        default:
            print("NOPE")
        }
        
        taskView.accessibilityIdentifier = "TasksTable"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.taskView.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.addBtn.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.addBtn.setTitleColor(Model.get.textColours[indexChosen.mainColour], for: .normal)
        self.taskView.reloadData()
    }
    
    @IBAction func addTask(sender: AnyObject) {
        let taskAlert = UIAlertController(title: "New task", message: "Enter your task name", preferredStyle: .alert)
        
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
//            if let taskContent = taskAlert.textFields?.first?.text {
//                let task = String(taskContent)
//                let ref = self.dbRef.child("task").child(taskContent)
//                let taskRef = ref.child("name")
//                let catRef = ref.child("cat")
//                taskRef.setValue(task)
//                catRef.setValue(self.cellChosen)
//            }
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            //Checking if the same task name has already existed in the category
            
            var i = 0
            
            repeat {
                if (taskAlert.textFields![0].text?.caseInsensitiveCompare(self.chosenList[i]) == .orderedSame) {
                    self.unsuccessfulInput()
                    break
                }
                i += 1
            } while (i < self.chosenList.count)
            
            if (i == self.chosenList.count) {
                self.successInput()
            }
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
        }))
        
        taskAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(taskAlert, animated: true, completion: nil)
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    func unsuccessfulInput() {
        let validationAlert = UIAlertController(title: "Not Allowed", message: "You already have the same task name inside this category!", preferredStyle: .alert)
        validationAlert.setValue(NSAttributedString(string: "Not Allowed", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        validationAlert.setValue(NSAttributedString(string: "You already have the same task name inside this category!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
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
        let successAlert = UIAlertController(title: "Success", message: "Successfully added task into this category!", preferredStyle: .alert)
        successAlert.setValue(NSAttributedString(string: "Success", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        successAlert.setValue(NSAttributedString(string: "Successfully added task into this category!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
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
    
    //swipe to remove task
    func tableView(_ taskView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let task = tasks[indexPath.row]
//            
//            task.itemRef?.removeValue()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // number of rows in table view
    func tableView(_ taskView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return self.chosenList.count
            case 1:
                return self.arr.count //just for testing
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
        
        switch indexPath.section {
            case 0:
                // set the text from the data model
                cell.taskName.text = self.chosenList[indexPath.row]
                cell.taskName.textColor = Model.get.textColours[indexChosen.mainColour]
                cell.taskDetailsLbl.text = "1 exp, 1 g" //don't forget to change this one to the real number of exp & gold
                cell.taskDetailsLbl.textColor = Model.get.textColours[indexChosen.mainColour]
                
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                
                cell.checkImg.image = UIImage(named: "checkboxUnchecked")?.withRenderingMode(.alwaysTemplate)
                
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                
                cell.checkImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
                cell.accessibilityIdentifier = "TasksCell_\(indexPath.row)"
                
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                
                //I made the buttons go to 2 separate functions
                //This one will go to buttonClicked, where now it's just showing an alert, but u can change it with your code to calculate and store the exp & gold
                cell.checkButton.tag = indexPath.row
                cell.checkButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
            
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
            case 1:
                // set the text from the data model
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: arr[indexPath.row])
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.taskName.attributedText = attributeString
                cell.taskName.textColor = Model.get.textColours[indexChosen.mainColour].withAlphaComponent(0.3)
                cell.taskDetailsLbl.text = "0 exp, 0 g" //don't forget to change this one to the real number of exp & gold
                cell.taskDetailsLbl.textColor = Model.get.textColours[indexChosen.mainColour].withAlphaComponent(0.3)
                
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                
                cell.checkImg.image = UIImage(named: "checkboxChecked")?.withRenderingMode(.alwaysTemplate)
                
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                
                cell.checkImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
                cell.accessibilityIdentifier = "CompletedTasksCell_\(indexPath.row)"
                
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                
                //I made the buttons go to 2 separate functions
                //This one will go to completedClicked, where it will show an alert telling the user that they have completed this task and they cannot undo it
                cell.checkButton.tag = indexPath.row
                cell.checkButton.addTarget(self, action: #selector(completedClicked(sender:)), for: UIControlEvents.touchUpInside)
            
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
                //*********************************************************//
            default:
                cell.taskName.text = "Error!"
        }
        
        cell.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        let backgroundView = UIView()
        backgroundView.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        cell.selectedBackgroundView = backgroundView
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    //This is where the button's methods are
    
    func buttonClicked(sender: UIButton) {
        let alert = UIAlertController(title: "Done", message: "Yay you finished task number \(sender.tag + 1)!", preferredStyle: .alert)
        
        alert.setValue(NSAttributedString(string: "Done", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: "Yay you finished task number \(sender.tag + 1)!", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = alert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        alert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func completedClicked(sender: UIButton) {
        let alert = UIAlertController(title: "Finished", message: "You have already finished task number \(sender.tag + 1). You cannot undo this action.", preferredStyle: .alert)
        
        alert.setValue(NSAttributedString(string: "Finished", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: "You have already finished task number \(sender.tag + 1). You cannot undo this action.", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = alert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        alert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    // method to run when table view cell is tapped
    func tableView(_ taskView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = taskView.cellForRow(at: indexPath) as! TasksViewCellController
        taskView.deselectRow(at: indexPath, animated:true)
        
        let data = (cell.taskName.text)
        varPassed.taskToInfo = data!
        
        performSegue(withIdentifier: "TasksToCustom", sender: cell)
        
    }
    
}
