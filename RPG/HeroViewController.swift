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

public var comps = [Task]()
public var tasks = [Task]()
public var cat = [String]()
public var lifeComps = [Task]()

struct varPassed {
    static var catToTask = ""
    static var taskToInfo = ""
    static var popupPassed = ""
    static var uid = ""
    static var totalExp = 0
    static var totalGold = 0
    static var currLvl = 0
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
    //I made a new variable
    var totalExp: Int = 0

    @IBOutlet weak var loginlogout: UIBarButtonItem!
    @IBOutlet weak var HeroLbl: UILabel!
    @IBOutlet weak var ExpLbl: UILabel!
    @IBOutlet weak var LvlLbl: UILabel!
    @IBOutlet weak var GoldLbl: UILabel!
    @IBOutlet weak var ExpPgb: UIProgressView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var JobLbl: UILabel!
    @IBOutlet weak var LifetimeLbl: UILabel!
    @IBOutlet weak var LifetimeLbl2: UILabel!
    @IBOutlet weak var TaskCountLbl: UILabel!
    //Change the exp multiplier label to total exp
    @IBOutlet weak var TotalExpLbl: UILabel!
    @IBOutlet weak var HeroNameButton: UIButton!

    @IBAction func changeName(_ sender: Any) {
        self.changeHeroName()
    }
    
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
                self.signInWithoutCancel()
                
                
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
            signInWithoutCancel()
        }

        
    }
    
    func signInWithoutCancel(){
        self.loginlogout.title = "Login/Signup"
        let userAlert = UIAlertController(title: "Login/Sign up", message: "Enter email and password", preferredStyle: .alert)
        // themes selected by user
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
        }))
        
        self.present(userAlert, animated: true, completion: nil)
        
        varPassed.uid = ""

    }
    
    func startObservingDB (){

        
        dbRef.observe(DataEventType.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let name = value?["heroName"] as? String ?? "Change hero name"
            let exp = value?["totalExp"] as? Int ?? 0
            let gold = value?["totalGold"] as? Int ?? 0
            varPassed.totalExp = exp
            varPassed.totalGold = gold
            self.currGold = gold
            self.totalExp = exp
            self.calcLevel()
            self.calcXP()
            
            self.HeroLbl.text? = name
            self.ExpLbl.text? = String(exp) + " exp / " + String(format: "%.0f", pow(Double((self.currLvl + 1) * 4), 2)) + self.EXP
            self.GoldLbl.text? = String(gold) + self.GOLD

            self.generateJobName()
            self.TotalExpLbl.text? = "Total Accumulated Exp: \(self.totalExp)"
            
            
        }){ (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated:true, completion:nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                
            }))
            
        }
        
        dbRef.child("task").observe(DataEventType.value, with: { (snapshot) in
            var compTasks = [Task]()
            var incompTasks = [Task]()
            for item in snapshot.children {
                let taskObject = Task(snapshot: item as! DataSnapshot)
                if taskObject.comp == true{
                        compTasks.append(taskObject)
                }else{
                        incompTasks.append(taskObject)
                }
            }
            lifeComps = compTasks
            tasks = incompTasks
            let lifeCount = lifeComps.count
            self.LifetimeLbl.text = "Lifetime completed tasks: \(String(lifeCount))"
            self.LifetimeLbl2.text = "Lifetime completed tasks: \(String(lifeCount))"
            self.TaskCountLbl.text = "Current Task Count: \(String(tasks.count))"
            
        }){ (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated:true, completion:nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                
            }))
        }
        
        dbRef.child("reward").child("pic").observe(DataEventType.value, with: { (snapshot:DataSnapshot) in
            
            for item in snapshot.children {
                let pic = item as! DataSnapshot
                Model.get.profilePictureFlags[Int(pic.key)!] = true
            }

        }) { (error) in
            print(error.localizedDescription)
        }
        dbRef.child("reward").child("main").observe(DataEventType.value, with: { (snapshot:DataSnapshot) in
            
            for item in snapshot.children {
                let main = item as! DataSnapshot
                Model.get.mainColourFlags[Int(main.key)!] = true
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        dbRef.child("reward").child("secondary").observe(DataEventType.value, with: { (snapshot:DataSnapshot) in
            
            for item in snapshot.children {
                let secondary = item as! DataSnapshot
                Model.get.secondaryColourFlags[Int(secondary.key)!] = true
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //settings
        dbRef.child("setting").observe(DataEventType.value, with: { (snapshot:DataSnapshot) in

            let value = snapshot.value as? NSDictionary
            let main = value?["main"] as? String ?? ""
            let secondary = value?["secondary"] as? String ?? ""
            let pic = value?["pic"] as? String ?? "Birb1"
            let secondaryToInt = Int(secondary) ?? 0
            let mainToInt = Int(main) ?? 0
            indexChosen.mainColour = mainToInt
            indexChosen.secondaryColour = secondaryToInt
            indexChosen.profilePicture = pic
            
            self.view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
            self.HeroLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.ExpLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.LvlLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.GoldLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.JobLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.TotalExpLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.LifetimeLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.LifetimeLbl2.textColor = Model.get.textColours[indexChosen.mainColour]
            self.TaskCountLbl.textColor = Model.get.textColours[indexChosen.mainColour]
            self.ExpPgb.trackTintColor = Model.get.extraColours1[indexChosen.mainColour]
            self.ExpPgb.progressTintColor = Model.get.extraColours2[indexChosen.mainColour]
            self.tabBarController?.tabBar.barTintColor = Model.get.secondaryColours[indexChosen.secondaryColour]
            self.tabBarController?.tabBar.tintColor = Model.get.extraColours1[indexChosen.secondaryColour]
            self.profilePicture.image = UIImage(named: indexChosen.profilePicture)
            self.navigationController?.navigationBar.barTintColor = Model.get.secondaryColours[indexChosen.secondaryColour]
            UINavigationBar.appearance().barTintColor = Model.get.secondaryColours[indexChosen.secondaryColour]
            self.navigationController?.navigationBar.tintColor = Model.get.extraColours1[indexChosen.secondaryColour]
            UINavigationBar.appearance().tintColor = Model.get.extraColours1[indexChosen.secondaryColour]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Model.get.extraColours1[indexChosen.secondaryColour]]
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : Model.get.extraColours1[indexChosen.secondaryColour]]


        }){ (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated:true, completion:nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                
            }))
        }



        
        //This is to initialize theme colour, only exists in this class because this is the first controller called
        //Cannot be put on AppDelegate somehow (it seems that the appearance() funtion in the UITabBar works in a different way than the one in UINavigationBar)

        
        
    }
    
    func calcLevel (){
        let level = sqrt(Double(self.totalExp)) * 0.25
        self.LvlLbl.text? = self.LVL + String(format: "%.0f", floor(level))
        self.currLvl = Int(floor(level))
        varPassed.currLvl = self.currLvl

        
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
    
    
    func changeHeroName(){
        //alert to change name goes here
        let heroAlert = UIAlertController(title: "Hero name", message: "Choose your hero's name", preferredStyle: .alert)
        heroAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "New hero name"
        }
        heroAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action:UIAlertAction) in
            if let heroContent = heroAlert.textFields?.first?.text {
                let hero = String(heroContent)
                
                let heroRef = self.dbRef.child("heroName")
                
                heroRef.setValue(hero)
                
            }
        }))
        self.present(heroAlert, animated: true, completion: nil)
    }
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
    

}
