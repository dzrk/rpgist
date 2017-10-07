import UIKit
import FirebaseDatabase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // cell reuse id (cells that scroll out of view can be reused)
//    let cellReuseIdentifier = "cell"
    var dbRef:DatabaseReference!
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("TESTTTT\(User)")
        dbRef = Database.database().reference().child(varPassed.uid)
        startObservingDB()
        // Register the table view cell class and its reuse id
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "FirstViewTable"

    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        self.addBtn.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        self.addBtn.setTitleColor(Model.get.textColours[indexChosen.mainColour], for: .normal)
        self.tableView.reloadData()
        
    }
    func startObservingDB (){
        //        let userID = Auth.auth().currentUser?.uid
        
        dbRef.child("category").observe(.value, with: { (snapshot:DataSnapshot) in
            var newCats = [String]()
            
            for item in snapshot.children {
                let cats = item as! DataSnapshot
                newCats.append(cats.value as! String)
            }
            
            cat = newCats
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addCategory(sender: AnyObject) {
        let catAlert = UIAlertController(title: "New category", message: "Enter your category", preferredStyle: .alert)
        
        // themes set by user
        catAlert.setValue(NSAttributedString(string: "New Category", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedTitle")
        catAlert.setValue(NSAttributedString(string: "Enter your category", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName : Model.get.textColours[indexChosen.mainColour]]), forKey: "attributedMessage")
        
        let subview1 = catAlert.view.subviews.first! as UIView
        let subview2 = subview1.subviews.first! as UIView
        let view = subview2.subviews.first! as UIView
        view.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        view.tintColor = Model.get.textColours[indexChosen.mainColour]
        catAlert.view.tintColor = Model.get.textColours[indexChosen.mainColour]
        
        // create new category
        catAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "New category name"
        }
        catAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action:UIAlertAction) in
            if let catContent = catAlert.textFields?.first?.text {
                let cat = String(catContent)
                
                let catRef = self.dbRef.child("category").child(catContent)
                
                catRef.setValue(cat)
                
            }
        }))
        catAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(catAlert, animated: true, completion: nil)
        
        
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FirstViewCell") as! FirstViewCellController

        let name = cat[indexPath.row]
        // set the text from the data model
        cell.textLabel?.text = String(name)
        cell.textLabel?.textColor = Model.get.textColours[indexChosen.mainColour]
        cell.backgroundColor = Model.get.mainColours[indexChosen.mainColour]
        let backgroundView = UIView()
        backgroundView.backgroundColor = Model.get.extraColours1[indexChosen.mainColour]
        cell.taskCountLbl.textColor = Model.get.textColours[indexChosen.mainColour]
        cell.accessibilityIdentifier = "FirstViewCell_\(indexPath.row)"

        cell.selectedBackgroundView = backgroundView
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated:true)

        let data = (cell?.textLabel?.text)
        varPassed.catToTask = data!

        performSegue(withIdentifier: "FirstViewToTaskCont", sender: cell)
        
    }
}
