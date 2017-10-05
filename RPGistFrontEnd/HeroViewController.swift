//
//  HeroViewController.swift
//  RPG
//
//  Created by Derrick Phung on 14/9/17.
//  Copyright © 2017 Derrick. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import FirebaseDatabase

public var tasks = [Task]()
public var cat = [String]()

class HeroViewController: UIViewController {
    static var get: HeroViewController = HeroViewController()
    
    let EXP:String = " exp"
    let LVL:String = "Level "
    let GOLD:String = " gold"
    var currExp:Int = 0
    var currGold:Int = 0
    var currLvl:Int = 0
    
//    var dbRef:DatabaseReference!
    @IBOutlet weak var HeroLbl: UILabel!
    @IBOutlet weak var ExpLbl: UILabel!
    @IBOutlet weak var LvlLbl: UILabel!
    @IBOutlet weak var GoldLbl: UILabel!
    @IBOutlet weak var ExpPgb: UIProgressView!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var JobLbl: UILabel!
    @IBOutlet weak var ExpMultiplierLbl: UILabel!
    @IBOutlet weak var LifetimeLbl: UILabel!
    @IBOutlet weak var LifetimeLbl2: UILabel!
    @IBOutlet weak var TaskCountLbl: UILabel!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   dbRef = Database.database().reference().child("user-details") //root of json tree -> user-details
        //        startObservingDB()
        //        print(Auth.auth().currentUser?.email)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialization()
        
//        Auth.auth().addStateDidChangeListener({ (auth, user) in
//            if let user = user {
//                print("Welcome \(user.email)")
//                print(user.uid)
//                
//                self.startObservingDB()
//            }else{
//                let alert = UIAlertController(title: "Error", message: "You need to sign up or login first", preferredStyle: .alert)
//                self.present(alert, animated:true, completion:nil)
//                print("You need to sign up or login first")
//            }
//        })
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        self.view.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        self.profilePicture.image = UIImage(named: Model.get.profilePictures[Model.get.profilePictureChosenIndex])
        self.HeroLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.ExpLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.LvlLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.GoldLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.JobLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.ExpMultiplierLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.LifetimeLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.LifetimeLbl2.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.TaskCountLbl.textColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        self.ExpPgb.trackTintColor = Model.get.extraColours2[Model.get.mainColourChosenIndex]
        self.ExpPgb.progressTintColor = Model.get.extraColours1[Model.get.mainColourChosenIndex]
        
        //This is to initialize theme colour, only exists in this class because this is the first controller called
        //Cannot be put on AppDelegate somehow (it seems that the appearance() funtion in the UITabBar works in a different way than the one in UINavigationBar)
        self.tabBarController?.tabBar.barTintColor = Model.get.secondaryColours[Model.get.secondaryColourChosenIndex]
        self.tabBarController?.tabBar.tintColor = Model.get.extraColours1[Model.get.secondaryColourChosenIndex]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
    }
    
    func initialization() {
        let exp = 937
        let name = "Arcovine"
        let gold = 153
        
        self.currExp = exp
        self.currGold = gold
        self.calcLevel()
        self.calcXP()
        
        self.HeroLbl.text? = name
        self.ExpLbl.text? = String(exp) + " exp / " + String(format: "%.0f", pow(Double((currLvl + 1) * 4), 2)) + self.EXP
        self.GoldLbl.text? = String(gold) + self.GOLD
    }
    
    @IBAction func loginAndSignUp(sender: AnyObject) {
        let userAlert = UIAlertController(title: "Login/Sign up", message: "Enter email and password", preferredStyle: .alert)
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        userAlert.setValue(NSAttributedString(string: "Login/Sign up", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[Model.get.mainColourChosenIndex]]), forKey: "attributedTitle")
        userAlert.setValue(NSAttributedString(string: "Enter email and password", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[Model.get.mainColourChosenIndex]]), forKey: "attributedMessage")
        
        let subview1 = userAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[Model.get.mainColourChosenIndex]
        view.tintColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        userAlert.view.tintColor = Model.get.textColours[Model.get.mainColourChosenIndex]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        userAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "email"
        }
        
        userAlert.addTextField { (textfield:UITextField) in
            textfield.isSecureTextEntry = true
            textfield.placeholder = "password"
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            
            textfield.accessibilityIdentifier = "password"
            
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
            //*********************************************************//
        }
        
        userAlert.addAction(UIAlertAction(title: "Sign in", style: .default, handler: { (action:UIAlertAction) in
//            let emailTextField = userAlert.textFields!.first!
//            let passwordtextField = userAlert.textFields!.last!
//        
//            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordtextField.text!, completion: { (user, err) in
//                if let error = err {
//                    print(error.localizedDescription)
//                }
//            })
        }))
        
        userAlert.addAction(UIAlertAction(title: "Sign up", style: .default, handler: { (action:UIAlertAction) in
//            let emailTextField = userAlert.textFields!.first!
//            let passwordtextField = userAlert.textFields!.last!
//        
//            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordtextField.text!, completion: { (user, err) in
//                if let error = err {
//                    print(error.localizedDescription)
//                }
//            })
        }))
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        userAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:UIAlertAction) in
            //do something
        }))
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        self.present(userAlert, animated: true, completion: nil)
    }
    
//    func startObservingDB (){
//        dbRef.observe(DataEventType.value, with: { (snapshot) in
//            
//            let value = snapshot.value as? NSDictionary
//            let name = value?["heroName"] as? String ?? ""
//            let exp = value?["totalExp"] as? Int ?? 0
//            let gold = value?["totalGold"] as? Int ?? 0
//            
//            self.HeroLbl.text? = name
//            self.ExpLbl.text? = String(exp) + self.EXP
//            self.GoldLbl.text? = String(gold) + self.GOLD
//            self.currExp = exp
//            self.calcLevel()
//        }){ (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    func calcLevel (){
        let level = sqrt(Double(self.currExp)) * 0.25
        self.LvlLbl.text? = self.LVL + String(format: "%.0f", floor(level))
        self.currLvl = Int(floor(level))
        //print("max: \(ceil(level)), min: \(floor(level))")
    }
    
    func calcXP() {
        let min = pow(Double(currLvl * 4), 2)
        let max = pow(Double((currLvl + 1) * 4), 2)
        let progress:Double = (Double(currExp) - min) / (max - min)
        
        self.ExpPgb.setProgress(Float(progress), animated: false)
    }
}
