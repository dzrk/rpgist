//
//  TaskDetailsController.swift
//  RPGistFrontEnd
//
//  Created by Priscilla Jofani Oetomo on 9/20/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//

import UIKit

class TaskDetailsController: UIViewController {
    @IBOutlet weak var placeholder1: UIView!
    @IBOutlet weak var placeholder2: UIView!
    @IBOutlet weak var placeholder3: UIView!
    @IBOutlet weak var placeholder4: UIView!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var description1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var description2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var description3: UILabel!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var description4: UILabel!
    
    @IBOutlet weak var expBtn: UIButton!
    @IBOutlet weak var goldBtn: UIButton!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var dueBtn: UIButton!
    
    @IBAction func goldBtnPressed(sender: AnyObject) {
        let goldInfoAlert = UIAlertController(title: "Gold Amount", message: "You are rewarded ... gold", preferredStyle: .alert)
        goldInfoAlert.setValue(NSAttributedString(string: "Gold Amount", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[Model.get.mainColourChosenIndex]]), forKey: "attributedTitle")
        goldInfoAlert.setValue(NSAttributedString(string: "You are rewarded ... gold", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[Model.get.mainColourChosenIndex]]), forKey: "attributedMessage")
        
        let subview1 = goldInfoAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        view.tintColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        goldInfoAlert.view.tintColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        
        goldInfoAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction) in
            //do something
        }))
        self.present(goldInfoAlert, animated: true, completion: nil)
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        expBtn.accessibilityIdentifier = "expBtn"
        goldBtn.accessibilityIdentifier = "goldBtn"
        notesBtn.accessibilityIdentifier = "notesBtn"
        dueBtn.accessibilityIdentifier = "dueBtn"
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        placeholder1.layer.cornerRadius = 25
        placeholder2.layer.cornerRadius = 25
        placeholder3.layer.cornerRadius = 25
        placeholder4.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        self.placeholder1.backgroundColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        self.placeholder2.backgroundColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        self.placeholder3.backgroundColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        self.placeholder4.backgroundColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        
        self.title1.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.description1.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.title2.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.description2.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.title3.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.description3.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.title4.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.description4.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
    }
}
