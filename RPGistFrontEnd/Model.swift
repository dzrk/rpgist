//
//  Model.swift
//  RPG
//
//  Created by Derrick Phung on 26/8/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import UIKit


//*********************************************************//
//*********************************************************//
//*********************************************************//
//*********************************************************//
//*********************************************************//

struct indexChosen {
    static var mainColour = 0
    static var secondaryColour = 0
    static var profilePicture = "Birb1"
}

//*********************************************************//
//*********************************************************//
//*********************************************************//
//*********************************************************//
//*********************************************************//

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
    
    var mainColours = [UIColor(red:0.33, green:0.36, blue:0.43, alpha:1.0),
                       UIColor(red:0.04, green:0.22, blue:0.28, alpha:1.0),
                       UIColor(red:0.07, green:0.29, blue:0.37, alpha:1.0),
                       UIColor(red:0.22, green:0.25, blue:0.24, alpha:1.0),
                       UIColor(red:0.70, green:1.00, blue:0.62, alpha:1.0),
                       UIColor(red:0.85, green:0.84, blue:0.84, alpha:1.0)]
    
    var secondaryColours = [UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0),
                            UIColor(red:0.25, green:0.38, blue:0.40, alpha:1.0),
                            UIColor(red:0.78, green:0.85, blue:0.75, alpha:1.0),
                            UIColor(red:0.31, green:0.13, blue:0.18, alpha:1.0),
                            UIColor(red:0.69, green:0.99, blue:0.25, alpha:1.0),
                            UIColor(red:0.65, green:0.11, blue:0.24, alpha:1.0)]
    
    var textColours = [UIColor(red:1.00, green:0.93, blue:0.87, alpha:1.0),
                       UIColor(red:0.85, green:0.86, blue:0.95, alpha:1.0),
                       UIColor(red:0.95, green:0.91, blue:0.82, alpha:1.0),
                       UIColor(red:0.85, green:0.82, blue:0.87, alpha:1.0),
                       UIColor(red:0.24, green:0.09, blue:0.26, alpha:1.0),
                       UIColor(red:0.41, green:0.29, blue:0.22, alpha:1.0)]
    
    var extraColours1 = [UIColor(red:0.39, green:0.51, blue:0.50, alpha:1.0),
                         UIColor(red:0.67, green:0.69, blue:0.74, alpha:1.0),
                         UIColor(red:0.10, green:0.58, blue:0.44, alpha:1.0),
                         UIColor(red:0.67, green:0.29, blue:0.40, alpha:1.0),
                         UIColor(red:0.03, green:0.39, blue:0.46, alpha:1.0),
                         UIColor(red:0.96, green:0.66, blue:0.24, alpha:1.0)] //darker than extraColours2
    
    var extraColours2 = [UIColor(red:0.75, green:0.89, blue:0.86, alpha:1.0),
                         UIColor(red:0.82, green:0.80, blue:0.84, alpha:1.0),
                         UIColor(red:0.53, green:0.83, blue:0.60, alpha:1.0),
                         UIColor(red:0.74, green:0.55, blue:0.63, alpha:1.0),
                         UIColor(red:0.11, green:0.83, blue:0.69, alpha:1.0),
                         UIColor(red:0.57, green:0.75, blue:0.69, alpha:1.0)] //lighter than extraColours1
    
    var profilePictures = ["Birb1", "Birb2", "Birb3", "Cat1", "Cat2", "Cat3", "Goldfish1", "Goldfish2", "Goldfish3"]
    
    var mainColourFlags = [true, true, true, true, true, true, true, true, true]
    var secondaryColourFlags = [true, true, true, true, true, true, true, true, true]
    var profilePictureFlags = [true, true, true, true, false, false, false, false, false]
    
    var mainColourPrices = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    var secondaryColourPrices = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    var profilePicturePrices = [15, 30, 45, 15, 30, 45, 15, 30, 45]
    var profilePictureLevelReqs = [0, 20, 50, 0, 20, 50, 0, 20, 50]
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    var DescriptionLabel = ["Task name", "duration"]
    var ExperienceLabel = ["Exp: "]
    var RewardLabel = ["Reward: ", "Change Gold Reward"]
}
