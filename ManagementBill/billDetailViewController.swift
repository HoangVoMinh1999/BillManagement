//
//  billDetailViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/20/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Firebase

class billDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //---Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var shipdateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var noteLabel: UITextView!
    @IBOutlet weak var backButton: UIButton!
    //---Paramater
    var db_detail_bill:UserDefaults=UserDefaults()
    
    var items:Array<String>=[]
    var quantity:Array<String>=[]
    //---Action
    @IBAction func backButtonAction(_ sender: Any) {
        let scr=storyboard?.instantiateViewController(identifier: "bill_screen") as! billViewController
        present(scr,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let ID:String = db_detail_bill.value(forKey: "ID") as! String
        let date:String = db_detail_bill.value(forKey:"shipDate") as! String
        
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        ref.child("List_Bills").child(date).child(ID).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            self.nameLabel.text=value!["guestName"] as? String
            self.phoneLabel.text=value!["guestPhone"] as? String
            self.noteLabel.text=value!["note"] as? String
            self.shipdateLabel.text=value!["shipdate"] as? String
//            self.items.append(value!["detail_items"])
//            self.quantity.append(value!["detail_amount"])
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
        itemTableView.delegate=self
        itemTableView.dataSource=self
    }
    //---Func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:billDetailTableViewCell=itemTableView.dequeueReusableCell(withIdentifier: "detail_cell") as! billDetailTableViewCell
        
        return cell
    }
    
}
