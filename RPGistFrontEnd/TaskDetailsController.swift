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
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
