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
            print(value)
            print(username)
            self.helloLabel.text="Hello \(username)"
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }        // Do any additional setup after loading the view.
    }


}

