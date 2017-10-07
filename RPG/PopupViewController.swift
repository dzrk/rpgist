//
//  PopupViewController.swift
//  RPG
//
//  Created by Derrick Phung on 27/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
import FirebaseDatabase
class PopupViewController: UIViewController{
    var dbRef:DatabaseReference!
    
    @IBOutlet weak var textViewDesc: UITextView!
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
    
    @IBAction func savePopup(_ sender: Any) {
        dbRef.child("task").child(varPassed.taskToInfo).child("desc").setValue(textViewDesc.text)
        dismiss(animated:true, completion:nil)
    }
    
    @IBOutlet weak var popupView: UIView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        dbRef = Database.database().reference().child(varPassed.uid)
        dbRef.child("task").child(varPassed.taskToInfo).observe(DataEventType.value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let descript = value?["desc"] as? String ?? ""
                self.textViewDesc?.text = descript
            }){ (error) in
                print(error.localizedDescription)
            }
            
    }

}
