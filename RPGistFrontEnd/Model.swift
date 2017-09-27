//
//  Model.swift
//  RPG
//
//  Created by Derrick Phung on 26/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import UIKit

class Model
{
    static var get: Model = Model()
    private init()
    {
        
    }
    var images = ["coins-icon","exp-icon","calendar-icon","notepad-icon"]
    
    var taskMenu: [String] = ["Description",
                              "Experience",
                              "Reward",
                              "Deadline"] //not used yet
    var skills = ["Intelligence (2)","Willpower (1)","Strength (5)","Health (3)","Charisma (4)"]
    
    var rewards = ["placeholder-theme"]
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    var mainColours = [UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0), UIColor.black, UIColor.red, UIColor.darkGray]
    var secondaryColours = [UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0), UIColor.white, UIColor.yellow, UIColor.green]
    var profilePictures = ["Pic1", "Pic2", "Pic3", "Pic4", "Pic5", "Pic6", "Pic7", "Pic8", "Pic9", "Pic10", "Pic11", "Pic12", "Pic13", "Pic14", "Pic15", "Pic16"]
    
    var mainColourFlags = [true, true, false, false]
    var secondaryColourFlags = [true, true, true, false]
    var profilePictureFlags = [true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false]
    
    var mainColourPrices = [10, 20, 30, 40]
    var secondaryColourPrices = [10, 20, 30, 40, 50]
    var profilePicturePrices = [15, 15, 15, 15, 30, 30, 30, 30, 45, 45, 45, 45, 60, 60, 60, 60]
    
    var mainColourChosen = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
    var secondaryColourChosen = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
    var profilePictureChosen = "Pic1"
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    var DescriptionLabel = ["Task name", "duration"]
    var ExperienceLabel = ["Exp: "]
    var RewardLabel = ["Reward: ", "Change Gold Reward"]
}
