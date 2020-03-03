//
//  addBillViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Firebase
import RLBAlertsPickers



class addBillViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //---Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextFiled: UITextField!
    @IBOutlet weak var shipdateTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var productsTableView: UITableView!
    //---Paramater
    var new_bill=Bill(name: "", phone: "", product: [""], quantity: [""], note: "", shipdate: "", status: true)
    var date:Date!
    var size = UIScreen.main.bounds
    //---Action
    @IBAction func addButtonAction(_ sender: Any) {
        let alert:UIAlertController=UIAlertController(title: "Add item", message: "Choose item and quantity", preferredStyle: .alert)
        alert.addTextField { (item) in
            item.placeholder="Item"
        }
        alert.addTextField { (quantity) in
            quantity.placeholder="Quantity"
        }
        let addButton:UIAlertAction=UIAlertAction(title: "Add item", style: .default) { (addButton) in
            if (self.new_bill.product[0]==""){
                print("Add new item")
                self.new_bill.product[0]=alert.textFields![0].text!
                self.new_bill.quantity[0]=alert.textFields![1].text!
                self.productsTableView.reloadData()
            }
            else{
                print("More item")
                self.new_bill.product.append(alert.textFields![0].text!)
                self.new_bill.quantity.append(alert.textFields![1].text!)
                self.productsTableView.reloadData()
            }
        }
        alert.addAction(addButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteButtonAction(_ sender: Any) {
        let alert:UIAlertController=UIAlertController(title: "WARNING", message: "Do you want to remove this item ?", preferredStyle: .alert)
        let yesButton:UIAlertAction=UIAlertAction(title: "YES", style: .destructive) { (yesButton) in
            print("hello")
        }
        let noButton:UIAlertAction=UIAlertAction(title: "NO", style: .default, handler: nil)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        productsTableView.reloadData()
        present(alert,animated: true,completion: nil)
    }
    @IBAction func statusSwitch(_ sender: Any) {
        if (statusSwitch.isOn==true){
            statusLabel.text="Ready"
            new_bill.status=true
        }
        else{
            statusLabel.text="Delivered"
            new_bill.status=false
        }
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        new_bill.name=nameTextField.text!
        new_bill.phone=phoneTextFiled.text!
        new_bill.note=noteTextField.text!
        new_bill.shipdate=shipdateTextField.text!
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        let list_bills=ref.child("List_Bills")
        let bills_by_day=list_bills.child("\(new_bill.shipdate)")
        let bill=bills_by_day.childByAutoId()
        
        let current_bill:Dictionary<String,Any>=["guestName":"\(new_bill.name)","guestPhone":"\(new_bill.phone)","shipdate":"\(new_bill.shipdate)","detail_items":"\(new_bill.product)","detail_amount":"\(new_bill.quantity)","status":"\(new_bill.status)","note":"\(new_bill.note)"]
        bill.setValue(current_bill)
        let billScreen=storyboard?.instantiateViewController(identifier: "bill_screen") as! billViewController
        present(billScreen,animated: true,completion: nil)
    }
    @IBAction func shipDateAction(_ sender: Any) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: size.width, height: 300))
        datePicker.sizeToFit()
        datePicker.datePickerMode = .date
        alert.view.addSubview(datePicker)
        let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.shipdateTextField.text = datePicker.date.dateToString()
        }
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
//        alert.show()
        self.present(alert,animated:true,completion: nil)
    }
    @IBAction func backButton(_ sender: Any) {
        let billScreen=storyboard?.instantiateViewController(identifier: "bill_screen") as! billViewController
        present(billScreen,animated: true,completion: nil)
    }
    
    //---viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text="Ready"
        statusSwitch.isOn=true
        productsTableView.delegate=self
        productsTableView.dataSource=self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return new_bill.product.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:newbillTableViewCell=productsTableView.dequeueReusableCell(withIdentifier: "item_cell") as! newbillTableViewCell
        cell.itemLabel.text=new_bill.product[indexPath.row]
        cell.quantityLabel.text=new_bill.quantity[indexPath.row]
        if (cell.itemLabel.text==""){
            cell.deleteButton.isHidden=true
        }
        else{
            cell.deleteButton.isHidden=false
        }
        return cell
    }


}

extension Date{
    func dateToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="dd-MM-yyyy"
        let str = dateFormatter.string(from: self)
        return str
    }
}

