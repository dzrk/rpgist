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
        totalExp.text = "Exp gained: \(diff!*imp!) exp"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupSlider.layer.cornerRadius = 10
        popupSlider.layer.masksToBounds = true
        calcTotalExp()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

