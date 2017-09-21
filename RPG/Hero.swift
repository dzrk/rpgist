//
//  Hero.swift
//  RPG
//
//  Created by Derrick Phung on 14/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Hero {
    let key:String!
    let exp:Int!
    let itemRef:DatabaseReference?
    let heroName:String!
    
    init (exp:Int, heroName:String, key:String = "") {
        self.key = key
        self.exp = exp
        self.heroName = heroName
        self.itemRef = nil
    }
    
    init (snapshot:DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        if let snap = snapshot.value as? NSDictionary, let userExp = snap["totalExp"] as? Int {
            exp = userExp
        }else {
            exp = 0
        }
        
        if let snapName = snapshot.value as? NSDictionary, let profile = snapName["heroName"] as? String {
            heroName = profile
        }else {
            heroName = ""
        }
        
    }
//    
//    func toAnyObject() -> AnyObject {
//        return ["exp":exp, "heroName":heroName]
//    }
}
