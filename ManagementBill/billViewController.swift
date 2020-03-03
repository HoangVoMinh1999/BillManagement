//
//  billViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Firebase

class billViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    //---Outlet
    @IBOutlet weak var billTableViewController: UITableView!
    //---Paramater
    var db_bill:UserDefaults=UserDefaults()
    var ref: DatabaseReference!
    //---Action
    
    @IBAction func backButtonAction(_ sender: Any) {
        let main_scr=storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        present(main_scr, animated: true, completion: nil)
    }
    @IBAction func addButtonAction(_ sender: Any) {
        let scr=storyboard?.instantiateViewController(identifier: "new_bill") as! addBillViewController
        db_bill.set("CREATE NEW BILL", forKey: "new_bill")
        present(scr,animated: true,completion: nil)
    }
    //---
    override func viewDidLoad() {
        super.viewDidLoad()
        billTableViewController.delegate=self
        billTableViewController.dataSource=self
        billTableViewController.reloadData()
        // Do any additional setup after loading the view.
    }
    //---func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return db_bill.value(forKey: "amount_of_bills") as! Int
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list_bills:Array<Dictionary<String,String>>=self.db_bill.value(forKey: "list_of_bills") as! Array<Dictionary<String, String>>
        let cell:billTableViewCell=billTableViewController.dequeueReusableCell(withIdentifier: "bill_Cell") as! billTableViewCell
        cell.nameLabel.text = list_bills[indexPath.row]["guestName"]
        cell.shipDateLabel.text = list_bills[indexPath.row]["shipdate"]
        cell.statusLabel.text = list_bills[indexPath.row]["status"]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list_bills:Array<Dictionary<String,String>>=self.db_bill.value(forKey: "list_of_bills") as! Array<Dictionary<String, String>>
        let list_IDs:Array<String>=self.db_bill.value(forKey: "list_of_ID") as! Array<String>
        db_bill.set(list_bills[indexPath.row]["shipdate"], forKey: "shipDate")
        db_bill.set(list_IDs[indexPath.row],forKey:"ID")
        let scr=storyboard?.instantiateViewController(identifier: "detail_bill") as! billDetailViewController
        present(scr,animated: true,completion: nil)
    }
    //---func

}
