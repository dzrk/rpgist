import UIKit
import FirebaseDatabase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    var dbRef:DatabaseReference!
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("TESTTTT\(User)")
        dbRef = Database.database().reference().child(varPassed.uid)
        startObservingDB()
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self

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
        self.present(catAlert, animated: true, completion: nil)
        
        
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        let name = cat[indexPath.row]
        // set the text from the data model
        cell.textLabel?.text = String(name)
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor(red: 0.388, green:0.388, blue: 0.388, alpha:1.0)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.522, green:0.78, blue: 0.949, alpha:1.0)
        //#85C7F2 baby blue
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
