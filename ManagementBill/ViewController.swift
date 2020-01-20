//
//  ViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var billButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    //---Paramater
    var db_main_scr:UserDefaults=UserDefaults()
    var user:String="Khoa"

    //---Action
    @IBAction func billButtonAction(_ sender: Any) {
        let billScreen = storyboard?.instantiateViewController(identifier: "bill_screen") as! billViewController
        present(billScreen, animated: true, completion: nil)
    }
    //---
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text="Hello \(user)"
        // Do any additional setup after loading the view.
    }


}

