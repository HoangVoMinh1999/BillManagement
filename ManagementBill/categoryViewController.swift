//
//  categoryViewController.swift
//  
//
//  Created by Vo Minh Hoang on 2/15/20.
//

import UIKit
import Firebase
       
class categoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ref = Database.database().reference()
        var number:Int!
        let data = ref.child("List_Items").observe(DataEventType.value, with: { (snapshot) in
        let items = snapshot.value as? NSDictionary ?? [:]
        let list_items:Array<Dictionary<String,String>>=Array(items.allValues) as! Array<Dictionary<String, String>>
            number=list_items.count
        })
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:categoryTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: "itemCell") as! categoryTableViewCell
        ref = Database.database().reference()

        ref.child("List_Items").observe(DataEventType.value, with: { (snapshot) in
            let items = snapshot.value as? NSDictionary ?? [:]
            let list_items:Array<Dictionary<String,String>>=Array(items.allValues) as! Array<Dictionary<String, String>>
            cell.nameLabel.text=list_items[indexPath.row]["Item"]
            cell.amountLabel.text=list_items[indexPath.row]["Amount"]
            cell.itemImageView.image=UIImage(contentsOfFile: list_items[indexPath.row]["photoURL"]!)
        })

        return cell
    }
    

    //---Variable
    var category = UserDefaults()
    var ref: DatabaseReference!
    var list_items:Dictionary<String,String>!
    //---Outlet
    @IBOutlet weak var categoryTableView: UITableView!
    //---Action
    @IBAction func addItemAction(_ sender: Any) {
        let editItemViewController = storyboard?.instantiateViewController(identifier: "editItemViewController")
        category.set("ADD NEW ITEM", forKey: "title")
        present(editItemViewController!, animated: true, completion: nil)
    }
    @IBAction func changeInfoAction(_ sender: Any) {
        let editItemViewController = storyboard?.instantiateViewController(identifier: "editItemViewController")
        category.set("EDIT AN ITEM", forKey: "title")
        present(editItemViewController!, animated: true, completion: nil)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(identifier: "ViewController")
        present(viewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.dataSource=self
        categoryTableView.delegate=self
        categoryTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
}

