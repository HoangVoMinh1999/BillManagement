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
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
            let name = user.displayName
            print(name)
            currentUser=User(id: uid, name: "", email: email!, avatarURL:"String(describing: photoURL!)")
            print("----------\(String(describing: currentUser))")
            
            var ref: DatabaseReference!

            ref = Database.database().reference()
            let tablename=ref.child("List_Friend")
            let userid=tablename.child(currentUser.id)
            let user:Dictionary<String,String>=["email":currentUser.email]
            userid.setValue(user)
        }
        
        // Do any additional setup after loading the view.
    }


}

