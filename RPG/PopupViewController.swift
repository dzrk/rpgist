//
//  PopupViewController.swift
//  RPG
//
//  Created by Derrick Phung on 27/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
class PopupViewController: UIViewController{
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
    @IBOutlet weak var popupView: UIView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

}
