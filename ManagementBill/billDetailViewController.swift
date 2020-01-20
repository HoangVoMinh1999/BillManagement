//
//  billDetailViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/20/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

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
        let scr=storyboard?.instantiateViewController(identifier: "bill_screen")
        nameLabel.text=db_detail_bill.value(forKey: "detail_bill_name") as! String
        phoneLabel.text=db_detail_bill.value(forKey: "detail_bill_phone") as! String
        shipdateLabel.text=db_detail_bill.value(forKey: "detail_bill_shipdate") as! String
        noteLabel.text=db_detail_bill.value(forKey: "detail_bill_note") as! String
        if (db_detail_bill.value(forKey: "detail_bill_status") as! Bool == true)
        {
            statusLabel.text="Ready"
        }
        else
        {
            statusLabel.text="Delivered"
        }
        items = db_detail_bill.value(forKey: "detail_bill_product") as! Array<String>
        quantity = db_detail_bill.value(forKey: "detail_bill_quantity") as! Array<String>
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
        cell.itemLabel.text=items[indexPath.row]
        cell.quantityLabel.text=quantity[indexPath.row]
        return cell
    }
    
}
