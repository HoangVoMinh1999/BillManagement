//
//  ViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var billButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    //---Paramater
    var currentUser:User!
    var category = UserDefaults()
    var count_bills:Int=0
    var list_bills:Array<Dictionary<String,String>>=[]
    var list_ID:Array<String>=[]
    //---Action
    @IBAction func billButtonAction(_ sender: Any) {
        let billScreen = storyboard?.instantiateViewController(identifier: "bill_screen") as! billViewController
        present(billScreen, animated: true, completion: nil)
    }
    @IBAction func logoutButtonAction(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("Logout Successfully !!!")
            let loginViewController=storyboard?.instantiateViewController(identifier: "loginViewController") as! loginViewController
            present(loginViewController, animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    //---
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("List_User").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let username = value?["name"] as? String ?? ""
            print(username)
            self.helloLabel.text="Hello \(username)"
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        //---Load amount of list_item
        ref.child("List_Items").observe(DataEventType.value, with: { (snapshot) in
        let items = snapshot.value as? NSDictionary ?? [:]
        let list_items:Array<Dictionary<String,String>>=Array(items.allValues) as! Array<Dictionary<String, String>>
            self.category.set(list_items.count, forKey: "amount_of_items")
        })
        //---Load data if list_bilss
        ref.child("List_Bills").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String:Any] ?? [:]
            let list_days=Array(postDict.keys)
            for i in list_days{
                ref.child("List_Bills").child(i).observe(DataEventType.value, with: { (snapshot) in
                    let data = snapshot.value as? NSDictionary ?? [:]
                    let bills:Array<Dictionary<String,String>>=Array(data.allValues) as! Array<Dictionary<String, String>>
                    let IDs:Array<String>=Array(data.allKeys) as! Array<String>
                    self.count_bills+=bills.count
                    self.list_bills+=bills
                    self.list_ID+=IDs
                    self.category.set(self.count_bills,forKey:"amount_of_bills")
                    self.category.set(self.list_bills,forKey:"list_of_bills")
                    self.category.set(self.list_ID,forKey:"list_of_ID")
                    print(self.list_bills)
                    print(self.list_ID)
                })
            }
        })
        
        // Do any additional setup after loading the view.
    }


}

