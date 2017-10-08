//
//  Task.swift
//  RPG
//
//  Created by Derrick Phung on 14/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import FirebaseDatabase

public struct Task {
    
    let key:String!
    let due:String!
    let gold:Int!
    let exp:Int!
    let name:String!
    let cat:String!
    let comp:Bool!
    
    let itemRef:DatabaseReference?

    init (due:String, gold:Int, exp:Int, name:String, key:String = "", cat:String, comp:Bool) {
        self.key = key
        self.due = due
        self.gold = gold
        self.exp = exp
        self.name = name
        self.cat = cat
        self.comp = comp
        self.itemRef = nil
    }

    init (snapshot:DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let snap = snapshot.value as? NSDictionary, let dict = snap["due"] as? String {
            due = dict
        }else {
            due = ""
        }
        if let snap = snapshot.value as? NSDictionary, let dict = snap["gold"] as? Int {
            gold = dict
        }else {
            gold = 0
        }
        if let snap = snapshot.value as? NSDictionary, let dict = snap["exp"] as? Int {
            exp = dict
        }else {
            exp = 0
        }
        if let snap = snapshot.value as? NSDictionary, let dict = snap["name"] as? String {
            name = dict
        }else {
            name = ""
        }
        if let snap = snapshot.value as? NSDictionary, let dict = snap["cat"] as? String {
            cat = dict
        }else {
            cat = ""
        }
        if let snap = snapshot.value as? NSDictionary, let dict = snap["completed"] as? Bool {
            comp = dict
        }else {
            comp = false
        }
    }
    
}
