//
//  loginViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/21/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    //---Variable
    
    //---Outlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //---Action
    @IBAction func loginButtonAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if (error==nil){
                print("Login successfully !!!")
                self!.loggedIn()
            }
            else{
                let alert:UIAlertController=UIAlertController(title: "Warning", message: "Wrong email or password", preferredStyle: .alert)
                let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loggedIn()
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
extension UIViewController{
    func loggedIn(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil){
                print("Logged in")
                let viewController=self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
                self.present(viewController, animated: true, completion: nil)
            }
            else{
                print("Not login")
            }
        }
    }
}
