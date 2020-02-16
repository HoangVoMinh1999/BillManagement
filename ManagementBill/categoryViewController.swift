//
//  categoryViewController.swift
//  
//
//  Created by Vo Minh Hoang on 2/15/20.
//

import UIKit
import Firebase
       
class categoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number=category.value(forKey: "amount_of_items")
        return number as! Int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:categoryTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: "itemCell") as! categoryTableViewCell
        ref = Database.database().reference()

        ref.child("List_Items").observe(DataEventType.value, with: { (snapshot) in
            let items = snapshot.value as? NSDictionary ?? [:]
            let list_items:Array<Dictionary<String,String>>=Array(items.allValues) as! Array<Dictionary<String, String>>
            cell.nameLabel.text=list_items[indexPath.row]["Item"]
            cell.amountLabel.text=list_items[indexPath.row]["Amount"]
            cell.itemImageView.loadImage(link: list_items[indexPath.row]["photoURL"]!)
        })

        return cell
    }
    

    //---Variable
    var category = UserDefaults()
    var ref: DatabaseReference!
    var list_items:Dictionary<String,String>!
    //---Outlet
    @IBOutlet weak var categoryTableView: UITableView!
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
        categoryTableView.dataSource=self
        categoryTableView.delegate=self
        categoryTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
}
extension UIImageView{
    func loadImage(link:String){
        let queue:DispatchQueue=DispatchQueue(label: "Load Image", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
        let action:UIActivityIndicatorView=UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        action.frame = CGRect(x: self.frame.size.width/2, y: self.frame.size.height/2, width: 0, height: 0)
        action.color = UIColor.gray
        self.addSubview(action)
        action.startAnimating()
        
        queue.async {
            print(link)
            let url:URL = URL(string: link)!
            do{
                print("Hello")
                let data:Data = try Data(contentsOf: url)
                print("Hello 1")
                DispatchQueue.main.async {
                    print("Hello 2")
                    action.stopAnimating()
                    self.image=UIImage(data: data)
                }
                
            }
            catch{
                action.stopAnimating()
                print("Loi load hinh")
            }
        }
    }
}
