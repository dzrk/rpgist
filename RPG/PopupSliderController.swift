//
//  PopupSliderController.swift
//  RPG
//
//  Created by Derrick Phung on 10/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class PopupSliderController: UIViewController
{

    var dbRef:DatabaseReference!
    var diffVal = 1
    var impVal = 1
    var math = 0
    var gold = 0
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated:true, completion:nil)

    }

    @IBAction func saveChanges(_ sender: Any) {
        dbRef.child("task").child(varPassed.taskToInfo).child("exp").setValue(self.math)
        dbRef.child("task").child(varPassed.taskToInfo).child("gold").setValue(self.gold)
        let savedAlert = UIAlertController(title: "Saved exp!", message: "Gold has been updated!", preferredStyle: .alert)
        
        savedAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
            
        }))
        self.present(savedAlert, animated: true, completion: nil)
        dismiss(animated:true, completion:nil)


    }
    
    @IBOutlet weak var sliderDiff: UISlider!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var sliderImp: UISlider!
    @IBOutlet weak var importance: UILabel!
    @IBOutlet weak var totalExp: UILabel!
    
    @IBAction func sliderDiffValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.diffVal = currentValue
        difficulty.text = "\(currentValue)%"
        calcTotalExp()
        
    }
    
    @IBAction func sliderImpValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.impVal = currentValue
        importance.text = "\(currentValue)%"
        calcTotalExp()
        
    }
    
    func calcTotalExp(){
        let diff = Int(diffVal)
        let imp = Int(impVal)
        let maths = sqrt((Double(diff*imp)))
        let calcGold = Int(sqrt(maths) * 5)
        self.math = Int(round(maths))
        totalExp.text = "\(String(format: "%.0f", maths)) exp"
        self.gold = calcGold
        
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dbRef = Database.database().reference().child(varPassed.uid)
        calcTotalExp()
    }

}

