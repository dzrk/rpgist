//
//  PopupSliderController.swift
//  RPG
//
//  Created by Derrick Phung on 10/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import UIKit

class PopupSliderController: UIViewController
{
    @IBAction func saveChanges(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var popupSlider: UIView!
    
    @IBOutlet weak var sliderDiff: UISlider!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var sliderImp: UISlider!
    @IBOutlet weak var importance: UILabel!
    @IBOutlet weak var totalExp: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var difficultyLbl: UILabel!
    @IBOutlet weak var imporatanceLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBAction func sliderDiffValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        difficulty.text = "\(currentValue)"
        calcTotalExp()
        
    }
    
    @IBAction func sliderImpValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        importance.text = "\(currentValue)"
        calcTotalExp()
    }
    
    func calcTotalExp(){
        let diff = Int(difficulty.text!)
        let imp = Int(importance.text!)
        totalExp.text = "Exp gained: \(String(format: "%.0f", sqrt(Double(diff!*imp!)))) exp"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupSlider.layer.cornerRadius = 10
        popupSlider.layer.masksToBounds = true
        
        self.popupSlider.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.titleLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.difficultyLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.difficulty.textColor = Model.get.textColours[indexChosen.mainColour]
        self.imporatanceLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.importance.textColor = Model.get.textColours[indexChosen.mainColour]
        self.sliderDiff.thumbTintColor = Model.get.textColours[indexChosen.mainColour]
        self.sliderDiff.maximumTrackTintColor = Model.get.extraColours2[indexChosen.mainColour]
        self.sliderDiff.minimumTrackTintColor = Model.get.extraColours1[indexChosen.mainColour]
        self.sliderImp.thumbTintColor = Model.get.textColours[indexChosen.mainColour]
        self.sliderImp.maximumTrackTintColor = Model.get.extraColours2[indexChosen.mainColour]
        self.sliderImp.minimumTrackTintColor = Model.get.extraColours1[indexChosen.mainColour]
        self.totalExp.textColor = Model.get.textColours[indexChosen.mainColour]
        self.saveBtn.tintColor = Model.get.extraColours1[indexChosen.mainColour]
        self.cancelBtn.tintColor = Model.get.extraColours1[indexChosen.mainColour]
        
        self.sliderDiff.accessibilityIdentifier = "sliderDiff"
        self.sliderImp.accessibilityIdentifier = "sliderImp"
        
        calcTotalExp()
    }
    
}

