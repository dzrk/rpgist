//
//  HeroViewController.swift
//  RPG
//
//  Created by Derrick Phung on 14/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HeroViewController: UIViewController {
    let EXP:String = " exp"
    let LVL:String = "Level "
    var currExp:Int = 0
    var dbRef:DatabaseReference!

    @IBOutlet weak var HeroLbl: UILabel!
    @IBOutlet weak var ExpLbl: UILabel!
    @IBOutlet weak var LvlLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child("user-details") //root of json tree -> user-details
        startObservingDB()
        
        
    }

    func startObservingDB (){
        dbRef.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["heroName"] as? String ?? ""
            let exp = value?["exp"] as? Int ?? 0
            self.HeroLbl.text? = name
            self.ExpLbl.text? = String(exp) + self.EXP
            self.currExp = exp
            self.calcLevel()
        })
//        { (error:NSError) in
//            print(error.description)
//        }
    }
    
    func calcLevel (){
        
        self.LvlLbl.text? = self.LVL + String(self.currExp)
        
    }


}
