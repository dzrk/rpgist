//
//  PopupViewController.swift
//  RPG
//
//  Created by Derrick Phung on 27/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
class PopupDueDateController: UIViewController{
    @IBAction func saveChanges(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        self.popupView.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.titleLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.datePicker.setValue(Model.get.textColours[indexChosen.mainColour], forKey: "textColor")
        self.saveBtn.tintColor = Model.get.extraColours1[indexChosen.mainColour]
        self.cancelBtn.tintColor = Model.get.extraColours1[indexChosen.mainColour]
    }
}
