//
//  PopupViewController.swift
//  RPG
//
//  Created by Derrick Phung on 27/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
class PopupViewController: UIViewController{
    @IBAction func saveChanges(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var popupView: UIView!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        self.popupView.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        self.titleLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.notes.backgroundColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        self.notes.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.notes.layer.cornerRadius = 10
        self.notes.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15)
        self.saveBtn.tintColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        self.cancelBtn.tintColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
    }
}
