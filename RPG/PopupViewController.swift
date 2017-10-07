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
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!

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
        
        self.popupView.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.titleLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.textViewDesc.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.textViewDesc.textColor = Model.get.textColours[indexChosen.mainColour]
        self.textViewDesc.layer.cornerRadius = 10
        self.textViewDesc.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15)
        self.saveBtn.tintColor = Model.get.extraColours1[indexChosen.mainColour]
        self.cancelBtn.tintColor = Model.get.extraColours1[indexChosen.mainColour]
        
        self.textViewDesc.accessibilityIdentifier = "notes"

        
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
