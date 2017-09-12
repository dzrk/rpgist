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
    
    var DescriptionLabel = ["Task name", "duration"]
    var ExperienceLabel = ["Exp: "]
    var RewardLabel = ["Reward: ", "Change Gold Reward"]
}
