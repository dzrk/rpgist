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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholder1.layer.cornerRadius = 25
        placeholder2.layer.cornerRadius = 25
        placeholder3.layer.cornerRadius = 25
        placeholder4.layer.cornerRadius = 25
        self.view.backgroundColor = Model.get.mainColourChosen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Model.get.mainColourChosen
    }
}
