//
//  categoryViewController.swift
//  
//
//  Created by Vo Minh Hoang on 2/15/20.
//

import UIKit
import Firebase

class categoryViewController: UIViewController {
    //---Variable
    var category = UserDefaults()
    //---Outlet
    //---Action
    @IBAction func addItemAction(_ sender: Any) {
        let editItemViewController = storyboard?.instantiateViewController(identifier: "editItemViewController")
        category.set("ADD NEW ITEM", forKey: "title")
        present(editItemViewController!, animated: true, completion: nil)
    }
    @IBAction func changeInfoAction(_ sender: Any) {
        let editItemViewController = storyboard?.instantiateViewController(identifier: "editItemViewController")
        category.set("EDIT AN ITEM", forKey: "title")
        present(editItemViewController!, animated: true, completion: nil)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(identifier: "ViewController")
        present(viewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
