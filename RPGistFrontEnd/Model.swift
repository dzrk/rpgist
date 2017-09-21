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
    
    var mainColours = [UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0), UIColor.black, UIColor.red, UIColor.darkGray, UIColor.white, UIColor.lightGray, UIColor.yellow]
    var secondaryColours = [UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0), UIColor.white, UIColor.lightGray, UIColor.yellow, UIColor.black, UIColor.red, UIColor.darkGray]
    var profilePictures = ["Pic1", "Pic2", "Pic3", "Pic4", "Pic5", "Pic6", "Pic7"]
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    var DescriptionLabel = ["Task name", "duration"]
    var ExperienceLabel = ["Exp: "]
    var RewardLabel = ["Reward: ", "Change Gold Reward"]
}
