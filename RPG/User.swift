//
//  User.swift
//  RPG
//
//  Created by Derrick Phung on 14/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    let uid:String
    let email:String
    
    init(userData:User) {
        uid = userData.uid
        email = userData.email
    }
    
    init (uid:String, email:String) {
        self.uid = uid
        self.email = email
    }
}
