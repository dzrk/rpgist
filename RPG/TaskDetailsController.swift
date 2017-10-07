//
//  TaskDetailsController.swift
//  RPGistFrontEnd
//
//  Created by Priscilla Jofani Oetomo on 9/20/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//
import UIKit
import FirebaseDatabase

class TaskDetailsController: UIViewController {
    @IBOutlet weak var placeholder1: UIView!
    @IBOutlet weak var placeholder2: UIView!
    @IBOutlet weak var placeholder3: UIView!
    @IBOutlet weak var placeholder4: UIView!
    
    @IBOutlet weak public var cGold: UILabel!
    @IBOutlet weak public var cExp: UILabel!
    @IBOutlet weak public var cDue: UILabel!
    @IBOutlet weak public var cTitle: UILabel!
    var dbRef: DatabaseReference!
    
    @IBAction func goldPopup(sender: AnyObject) {
        let goldAlert = UIAlertController(title: "Gold", message: "Amount of gold rewarded scales with EXP", preferredStyle: .alert)

        goldAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
            
        }))
        self.present(goldAlert, animated: true, completion: nil)
    }
    
    public func reload(){
        
        dbRef = Database.database().reference().child(varPassed.uid).child("task").child(varPassed.taskToInfo)
        dbRef.observe(DataEventType.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let gold = value?["gold"] as? Int ?? 0
            let exp = value?["exp"] as? Int ?? 0
            let due = value?["due"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            self.cGold.text? = String(gold) + " g"
            self.cExp.text? = String(exp) + " exp"
            self.cDue.text? = due
            self.cTitle.text? = name
            self.title? = name
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        
        placeholder1.layer.cornerRadius = 25
        placeholder2.layer.cornerRadius = 25
        placeholder3.layer.cornerRadius = 25
        placeholder4.layer.cornerRadius = 25
    }
}
