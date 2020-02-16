//
//  editItemViewController.swift
//  
//
//  Created by Vo Minh Hoang on 2/15/20.
//

import UIKit
import Firebase


class editItemViewController: UIViewController {
    //---Variable
    var category = UserDefaults()
    var imgItemData:Data!
    var ref: DatabaseReference!
    
    var position=0 // Use for upload realtime database
    //---Outlet
    @IBOutlet weak var editItemLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var imageItem: UIImageView!
    
    //---Action
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
        let alert:UIAlertController=UIAlertController(title: "Warning", message: "Choose image from:", preferredStyle: .alert)
        //---Choose Gallery
        let galleryButton:UIAlertAction=UIAlertAction(title: "Gallery", style: .default) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                let imgPicker = UIImagePickerController()
                imgPicker.allowsEditing=false
                imgPicker.delegate=self
                imgPicker.sourceType=UIImagePickerController.SourceType.photoLibrary
                self.present(imgPicker, animated: true, completion: nil)
            }
        }
        alert.addAction(galleryButton)
        //---Choose Camera
        let cameraButton:UIAlertAction=UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)){
                let imgPicker = UIImagePickerController()
                imgPicker.allowsEditing=false
                imgPicker.delegate=self
                imgPicker.sourceType=UIImagePickerController.SourceType.camera
                self.present(imgPicker, animated: true, completion: nil)
            }
            else{
                let alert_cam:UIAlertController=UIAlertController(title: "Warning", message: "Camera is not existed", preferredStyle: .alert)
                self.present(alert_cam, animated: true) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        alert.addAction(cameraButton)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()

        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        //---Upload to Realtime Database
        ref = Database.database().reference()
                
        let List_Items=ref.child("List_Items")
        let itemName=List_Items.child("\(nameTextField.text!)")
        let item:Dictionary<String,String>=["Item":nameTextField.text!,"Amount":amountTextField.text!,"photoURL":"gs://billmanagement-dd52d.appspot.com/Item/\(nameTextField.text!)"]
        //---Check item existed
        ref.child("List_Items").child("\(nameTextField.text!)").observeSingleEvent(of: .value, with: { (snapshot) in

          let value = snapshot.value as? NSDictionary
            if (value == nil){
                // Create a reference to the file you want to upload
                let itemRef = storageRef.child("Item/\(self.nameTextField.text!).jpg")

                // Upload the file to the path "images/rivers.jpg"
                let uploadTask = itemRef.putData(self.imgItemData, metadata: nil) { (metadata, error) in
                  guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                  }
                  // Metadata contains file metadata such as size, content-type.
                    _ = metadata.size
                  // You can also access to download URL after upload.
                  itemRef.downloadURL { (url, error) in
                    guard url != nil else {
                      // Uh-oh, an error occurred!
                      return
                    }
                  }
                }
                // Resume the upload
                uploadTask.resume()
                itemName.setValue(item)
                print("Add item successfully")
            }
            else{
                print("Fail to add item")
            }
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editItemLabel.text=(category.value(forKey: "title") as! String)
        imageItem.isUserInteractionEnabled=true
        imageItem.isMultipleTouchEnabled=true
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
extension editItemViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imgChosen = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let size = max(imgChosen.size.width,imgChosen.size.height)
        if (size > 3000){
            imgItemData = imgChosen.jpegData(compressionQuality: 0.1)
        }
        else if (size > 1000){
            imgItemData=imgChosen.jpegData(compressionQuality: 0.3)
        }
        else{
            imgItemData=imgChosen.jpegData(compressionQuality: 1)
        }
        //---ImageItem= imgChosen
        imageItem.image=UIImage(data: imgItemData)
        dismiss(animated: true, completion: nil)
    }
}
