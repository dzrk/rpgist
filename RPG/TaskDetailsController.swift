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
    
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title4: UILabel!
    
    @IBOutlet weak var expBtn: UIButton!
    @IBOutlet weak var goldBtn: UIButton!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var dueBtn: UIButton!
    
    @IBOutlet weak var expImg: UIImageView!
    @IBOutlet weak var goldImg: UIImageView!
    @IBOutlet weak var notesImg: UIImageView!
    @IBOutlet weak var dueImg: UIImageView!
    
    var dbRef: DatabaseReference!
    
    @IBAction func goldPopup(sender: AnyObject) {
        let goldAlert = UIAlertController(title: "Gold", message: "Amount of gold rewarded scales with EXP", preferredStyle: .alert)
        
        goldAlert.setValue(NSAttributedString(string: "Gold", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        goldAlert.setValue(NSAttributedString(string: "Amount of gold rewarded scales with EXP", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = goldAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        goldAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
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
            self.title = name
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
        expBtn.accessibilityIdentifier = "expBtn"
        goldBtn.accessibilityIdentifier = "goldBtn"
        notesBtn.accessibilityIdentifier = "notesBtn"
        dueBtn.accessibilityIdentifier = "dueBtn"

    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        
        self.placeholder1.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.placeholder2.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.placeholder3.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.placeholder4.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        
        self.title1.textColor = Model.get.textColours[indexChosen.mainColour]
        self.cExp.textColor = Model.get.textColours[indexChosen.mainColour]
        self.title2.textColor = Model.get.textColours[indexChosen.mainColour]
        self.cGold.textColor = Model.get.textColours[indexChosen.mainColour]
        self.title3.textColor = Model.get.textColours[indexChosen.mainColour]
        self.cTitle.textColor = Model.get.textColours[indexChosen.mainColour]
        self.title4.textColor = Model.get.textColours[indexChosen.mainColour]
        self.cDue.textColor = Model.get.textColours[indexChosen.mainColour]
        
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
