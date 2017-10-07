//
//  PopupDueDateController.swift
//  RPG
//
//  Created by Derrick Phung on 27/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//
import UIKit
import FirebaseDatabase
class PopupDueDateController: UIViewController{
    var dbRef: DatabaseReference!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedDate: String?
    
    @IBAction func saveChanges(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: datePicker.date)
        self.selectedDate = strDate
        dbRef.child("due").setValue(self.selectedDate)
        dismiss(animated:true, completion:nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var popupView: UIView!
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        dbRef = Database.database().reference().child(varPassed.uid).child("task").child(varPassed.taskToInfo)
        dbRef.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let due = value?["due"] as? String ?? ""
            if due != ""{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
 
                let date = dateFormatter.date(from: due)
                self.datePicker.date = date!
            }
        }){ (error) in
            print(error.localizedDescription)
        }
    }
}
