//
//  addBillViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

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
        let billScreen=storyboard?.instantiateViewController(identifier: "bill_screen") as! billViewController
        billScreen.list_bill.append(new_bill)
        present(billScreen,animated: true,completion: nil)
    }
    
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
