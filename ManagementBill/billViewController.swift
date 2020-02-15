//
//  billViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

class billViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    //---Outlet
    @IBOutlet weak var billTableViewController: UITableView!
    //---Paramater
    var db_bill:UserDefaults=UserDefaults()
    
    var new_bill = Bill(name: "Tran Dang Khoa", phone: "0909090", product: ["Cuff","iWatch"], quantity: ["10","10"], note: "Silver",shipdate: "02/02/2021", status: true)
    var list_bill:Array<Bill>=[]
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
        list_bill.append(new_bill)
        billTableViewController.delegate=self
        billTableViewController.dataSource=self
        billTableViewController.reloadData()
        // Do any additional setup after loading the view.
    }
    //---func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_bill.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:billTableViewCell=billTableViewController.dequeueReusableCell(withIdentifier: "bill_Cell") as! billTableViewCell
        cell.nameLabel.text=list_bill[indexPath.row].name
        cell.shipDateLabel.text=list_bill[indexPath.row].shipdate
        if (list_bill[indexPath.row].status == true){
            cell.statusLabel.text="Ready"
        }
        else{
            cell.statusLabel.text="Delivered"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        db_bill.set(list_bill[indexPath.row].name, forKey: "detail_bill_name")
        db_bill.set(list_bill[indexPath.row].phone, forKey: "detail_bill_phone")
        db_bill.set(list_bill[indexPath.row].shipdate, forKey: "detail_bill_shipdate")
        db_bill.set(list_bill[indexPath.row].status, forKey: "detail_bill_status")
        db_bill.set(list_bill[indexPath.row].product, forKey: "detail_bill_product")
        db_bill.set(list_bill[indexPath.row].quantity, forKey: "detail_bill_quantity")
        db_bill.set(list_bill[indexPath.row].note, forKey: "detail_bill_note")
        let scr=storyboard?.instantiateViewController(identifier: "detail_bill") as! billDetailViewController
        present(scr,animated: true,completion: nil)
    }
    //---func

}
