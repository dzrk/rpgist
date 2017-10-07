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
    
    @IBOutlet weak var expImg: UIImageView!
    @IBOutlet weak var goldImg: UIImageView!
    @IBOutlet weak var notesImg: UIImageView!
    @IBOutlet weak var dueImg: UIImageView!
    
    @IBAction func goldBtnPressed(sender: AnyObject) {
        let goldInfoAlert = UIAlertController(title: "Gold Amount", message: "You are rewarded ... gold", preferredStyle: .alert)
        goldInfoAlert.setValue(NSAttributedString(string: "Gold Amount", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        goldInfoAlert.setValue(NSAttributedString(string: "You are rewarded ... gold", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = goldInfoAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        goldInfoAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        goldInfoAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(goldInfoAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expBtn.accessibilityIdentifier = "expBtn"
        goldBtn.accessibilityIdentifier = "goldBtn"
        notesBtn.accessibilityIdentifier = "notesBtn"
        dueBtn.accessibilityIdentifier = "dueBtn"
        
        placeholder1.layer.cornerRadius = 25
        placeholder2.layer.cornerRadius = 25
        placeholder3.layer.cornerRadius = 25
        placeholder4.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        
        self.placeholder1.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.placeholder2.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.placeholder3.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.placeholder4.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        
        self.title1.textColor = Model.get.textColours[indexChosen.mainColour]
        self.description1.textColor = Model.get.textColours[indexChosen.mainColour]
        self.title2.textColor = Model.get.textColours[indexChosen.mainColour]
        self.description2.textColor = Model.get.textColours[indexChosen.mainColour]
        self.title3.textColor = Model.get.textColours[indexChosen.mainColour]
        self.description3.textColor = Model.get.textColours[indexChosen.mainColour]
        self.title4.textColor = Model.get.textColours[indexChosen.mainColour]
        self.description4.textColor = Model.get.textColours[indexChosen.mainColour]
        
        self.expImg.image = self.expImg.image!.withRenderingMode(.alwaysTemplate)
        self.expImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
        
        self.goldImg.image = self.goldImg.image!.withRenderingMode(.alwaysTemplate)
        self.goldImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
        
        self.notesImg.image = self.notesImg.image!.withRenderingMode(.alwaysTemplate)
        self.notesImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
        
        self.dueImg.image = self.dueImg.image!.withRenderingMode(.alwaysTemplate)
        self.dueImg.tintColor = Model.get.secondaryColours[indexChosen.mainColour]
    }
}

