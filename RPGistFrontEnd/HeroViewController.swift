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
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    //I made a new variable
    var totalExp: Int = 0
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
//    var dbRef:DatabaseReference!
    @IBOutlet weak var HeroLbl: UILabel!
    @IBOutlet weak var ExpLbl: UILabel!
    @IBOutlet weak var LvlLbl: UILabel!
    @IBOutlet weak var GoldLbl: UILabel!
    @IBOutlet weak var ExpPgb: UIProgressView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var JobLbl: UILabel!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    //Change the exp multiplier label to total exp
//    @IBOutlet weak var ExpMultiplierLbl: UILabel!
    @IBOutlet weak var TotalExpLbl: UILabel!
    //And don't forget to unhook the old one and hook the new one up to the storyboard!
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    @IBOutlet weak var LifetimeLbl: UILabel!
    @IBOutlet weak var LifetimeLbl2: UILabel!
    @IBOutlet weak var TaskCountLbl: UILabel!
    
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
        
        self.view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.profilePicture.image = UIImage(named: indexChosen.profilePicture)
        self.HeroLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.ExpLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.LvlLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.GoldLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.JobLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        //Change this thing
//        self.ExpMultiplierLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        //To this:
        self.TotalExpLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.LifetimeLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.LifetimeLbl2.textColor = Model.get.textColours[indexChosen.mainColour]
        self.TaskCountLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        self.ExpPgb.trackTintColor = Model.get.extraColours1[indexChosen.mainColour]
        self.ExpPgb.progressTintColor = Model.get.extraColours2[indexChosen.mainColour]
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        //This is to initialize theme colour, only exists in this class because this is the first controller called
        //Cannot be put on AppDelegate somehow (it seems that the appearance() funtion in the UITabBar works in a different way than the one in UINavigationBar)
        self.tabBarController?.tabBar.barTintColor = Model.get.secondaryColours[indexChosen.secondaryColour]
        self.tabBarController?.tabBar.tintColor = Model.get.extraColours1[indexChosen.secondaryColour]
    }
    
    func initialization() {
        let exp = 937
        let name = "Arcovine"
        let gold = 153
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        //Change this (if u have it)
//        self.currExp = exp
        //To this
        self.totalExp = exp
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        self.currGold = gold
        self.calcLevel()
        self.calcXP()
        self.generateJobName()
        
        self.HeroLbl.text? = name
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        //I will be setting the exp label at the calcExp function now
//        self.ExpLbl.text? = String(exp) + " exp / " + String(format: "%.0f", pow(Double((currLvl + 1) * 4), 2)) + self.EXP
        
        self.TotalExpLbl.text? = "Total Accumulated Exp: \(self.totalExp)"
        
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        //*********************************************************//
        
        self.GoldLbl.text? = String(gold) + self.GOLD
    }
    
    @IBAction func loginAndSignUp(sender: AnyObject) {
        let userAlert = UIAlertController(title: "Login/Sign up", message: "Enter email and password", preferredStyle: .alert)
        
        userAlert.setValue(NSAttributedString(string: "Login/Sign up", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        userAlert.setValue(NSAttributedString(string: "Enter email and password", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = userAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        userAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        userAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "email"
        }
        
        userAlert.addTextField { (textfield:UITextField) in
            textfield.isSecureTextEntry = true
            textfield.placeholder = "password"
            textfield.accessibilityIdentifier = "password"
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
        
        userAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
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
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    
    //Pay attention to these functions cause I made some changes
    
    func calcLevel () {
        //First is over here
//        let level = sqrt(Double(self.currExp)) * 0.25
        //To this one:
        let level = sqrt(Double(self.totalExp)) * 0.25
        self.LvlLbl.text? = self.LVL + String(format: "%.0f", floor(level))
        self.currLvl = Int(floor(level))
    }
    
    func calcXP() {
        //Now I need to calculate the exp level that the user has in that level
        
        let min = pow(Double(currLvl * 4), 2) //This function stays but it's for a different purpose now
        self.currExp = self.totalExp - Int(min) //And that's how we got the user's current exp
        
        let max = pow(Double((currLvl + 1) * 4), 2)
        
        //Change this:
//        let progress:Double = (Double(currExp) - min) / (max - min)
        //To this:
        let progress:Double = Double(currExp) / (max - min)
        
        self.ExpPgb.setProgress(Float(progress), animated: false)
        
        //I'll also be setting the label under the progress bar here to make things simpler
        self.ExpLbl.text? = String(self.currExp) + self.EXP + " / " + String(format: "%.0f", (max - min)) + self.EXP
    }
    
    //Copy this whole function again because I changed the way I name the job
    func generateJobName() {
        var jobTitle:String
        
        if (self.currLvl < 6) {
            jobTitle = "Novice"
        } else if (self.currLvl < 11) {
            jobTitle = "Apprentice"
        } else if (self.currLvl < 21) {
            jobTitle = "Adept"
        } else if (self.currLvl < 36) {
            jobTitle = "Master"
        } else if (self.currLvl < 51) {
            jobTitle = "Grandmaster"
        } else {
            jobTitle = "Legendary"
        }
        
        //I'm trying to add the name of the animal in the profile picture to the end of the job title
        let pictureName = indexChosen.profilePicture //just getting the picture name
        let strLength = pictureName.characters.count //getting the length of the picture name string so that it can be reduced by 1 to just get the name of the animal without the evolution number
        let index = pictureName.index(pictureName.startIndex, offsetBy: strLength - 1) //setting the index to be used for the substring
        
        jobTitle += " \(pictureName.substring(to: index))" //adding the animal name to the end of the job title
        self.JobLbl.text = jobTitle //setting the job title label
    }
    
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
    //*********************************************************//
}
