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

public var tasks = [Task]()
public var cat = [String]()
struct varPassed {
    static var catToTask = ""
    static var taskToInfo = ""
    static var popupPassed = ""
    static var uid = ""
}

class HeroViewController: UIViewController {
    
    static var get: HeroViewController = HeroViewController()
    
    let EXP:String = " exp"
    let LVL:String = "Level "
    let GOLD:String = " gold"
    var currExp:Int = 0
    var currLvl:Int = 0
    var currGold:Int = 0
    var dbRef:DatabaseReference!

    @IBOutlet weak var loginlogout: UIBarButtonItem!
    @IBOutlet weak var HeroLbl: UILabel!
    @IBOutlet weak var ExpLbl: UILabel!
    @IBOutlet weak var LvlLbl: UILabel!
    @IBOutlet weak var GoldLbl: UILabel!
    @IBOutlet weak var ExpPgb: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        startObservingDB()
//        print(Auth.auth().currentUser?.email)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.loginlogout.title = "Logout"
//                print("Welcome \(user.email)")
//                print(user.uid)
                varPassed.uid = user.uid
                self.dbRef = Database.database().reference().child(varPassed.uid) //root of json tree -> user-details
                self.dbRef.child("uid").setValue(varPassed.uid)
                self.startObservingDB()
            }else{
                self.loginlogout.title = "Login"
                let alert = UIAlertController(title: "Sign in/Sign up", message: "Please login or signup", preferredStyle: .alert)
                self.present(alert, animated:true, completion:nil)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    
                }))
                varPassed.uid = ""
            }
        })
        
    }
    @IBAction func loginAndSignUp(sender: AnyObject) {
        if varPassed.uid != ""{
            do{
                try Auth.auth().signOut()
                
            }catch let error as NSError{
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated:true, completion:nil)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    
                }))
            }
        }else{
            varPassed.uid = ""
            signin()
        }

        
    }
    
    
    func startObservingDB (){

        
        dbRef.observe(DataEventType.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let name = value?["heroName"] as? String ?? ""
            let exp = value?["totalExp"] as? Int ?? 0
            let gold = value?["totalGold"] as? Int ?? 0

            self.currExp = exp
            self.currGold = gold
            
            self.calcLevel()
            self.calcXP()
            
            self.HeroLbl.text? = name
            self.ExpLbl.text? = String(exp) + " exp / " + String(format: "%.0f", pow(Double((self.currLvl + 1) * 4), 2)) + self.EXP
            self.GoldLbl.text? = String(gold) + self.GOLD
//            print("Welcome \(self.currentUser.email)")
//            print(self.currentUser.uid)
            

            
            
        }){ (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated:true, completion:nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                
            }))

        }
    }
    
    func calcLevel (){
        let level = sqrt(Double(self.currExp)) * 0.25
        self.LvlLbl.text? = self.LVL + String(format: "%.0f", floor(level))
        self.currLvl = Int(floor(level))
        
    }
    
    func calcXP() {
        let min = pow(Double(currLvl * 4), 2)
        let max = pow(Double((currLvl + 1) * 4), 2)
        let progress:Double = (Double(currExp) - min) / (max - min)
        
        self.ExpPgb.setProgress(Float(progress), animated: false)
    }
    
    func signin(){
        let userAlert = UIAlertController(title: "Login/Sign up", message: "Enter email and password", preferredStyle: .alert)
        userAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "email"
        }
        userAlert.addTextField { (textfield:UITextField) in
            textfield.isSecureTextEntry = true
            textfield.placeholder = "password"
        }
        
        userAlert.addAction(UIAlertAction(title: "Sign in", style: .default, handler: { (action:UIAlertAction) in
            let emailTextField = userAlert.textFields!.first!
            let passwordtextField = userAlert.textFields!.last!
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordtextField.text!, completion: { (user, err) in
                if let error = err {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    self.present(alert, animated:true, completion:nil)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                        
                    }))
                }else{
                    self.loginlogout.title = "Logout"
                }
            })
        }))
        
        userAlert.addAction(UIAlertAction(title: "Sign up", style: .default, handler: { (action:UIAlertAction) in
            let emailTextField = userAlert.textFields!.first!
            let passwordtextField = userAlert.textFields!.last!
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordtextField.text!, completion: { (user, err) in
                if let error = err {
//                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    self.present(alert, animated:true, completion:nil)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                        
                    }))

                }else{
                    self.loginlogout.title = "Logout"
                }
            })
            //alert to change name
        }))
        
        
        self.present(userAlert, animated: true, completion: nil)
        

    }
}
