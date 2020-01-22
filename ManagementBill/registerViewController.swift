//
//  registerViewController.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/22/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit
import Firebase

class registerViewController: UIViewController {
    //---Variable
    var imgData:Data!
    //---Outlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //---Action
    @IBAction func avatarTap(_ sender: UITapGestureRecognizer) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: "Choose image from", preferredStyle: .alert)
        let cameraButton:UIAlertAction=UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)){
                let imgPicker=UIImagePickerController()
                imgPicker.sourceType=UIImagePickerController.SourceType.camera
                imgPicker.delegate=self
                imgPicker.allowsEditing=false
                self.present(imgPicker, animated: true, completion: nil)
            }
            else{
                print("Khong co camera")
                let alert_cam:UIAlertController=UIAlertController(title: "Warnings", message: "Camera is not allowed", preferredStyle: .alert)
                self.present(alert_cam, animated: true, completion: nil)
            }
        }
        alert.addAction(cameraButton)
        //---Button Gallery
        let galleryButton:UIAlertAction=UIAlertAction(title: "Gallery", style: .default) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                let imgPicker=UIImagePickerController()
                imgPicker.sourceType=UIImagePickerController.SourceType.photoLibrary
                imgPicker.delegate=self
                imgPicker.allowsEditing=false
                self.present(imgPicker, animated: true, completion: nil)
            }
        }
        alert.addAction(galleryButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func registerAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if (error == nil){
                print("Dang ki thanh cong")
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if (error==nil){
                        print("Dang nhap thanh cong")
                    }
                    else{
                        print("Loi dang nhap")
                    }
                }
                // Get a reference to the storage service using the default Firebase App
                let storage = Storage.storage()

                // Create a storage reference from our storage service
                let storageRef = storage.reference()

                // Create a reference to the file you want to upload
                let avatarRef = storageRef.child("images/\(self.emailTextField.text!).jpg")

                // Upload the file to the path "images/rivers.jpg"
                let uploadTask = avatarRef.putData(self.imgData, metadata: nil) { (metadata, error) in
                  guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                  }
                  // Metadata contains file metadata such as size, content-type.
                  let size = metadata.size
                  // You can also access to download URL after upload.
                  avatarRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = self.emailTextField.text!
                      changeRequest?.commitChanges { (error) in
                        if (error==nil){
                            print("Update Successfully")
                        }
                        }
                      return
                    }
                  }
                }
                    
            }
            else{
                let alert:UIAlertController=UIAlertController(title: "Warning", message: "Fail to register", preferredStyle: .alert)
                let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImage.isUserInteractionEnabled=true
        avatarImage.isMultipleTouchEnabled=true
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
extension registerViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //---Take picture chose
        let imgChose = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //---Edit size of picture
        let imgSize = max(imgChose.size.width,imgChose.size.height)
        if (imgSize > 3000){
            imgData=imgChose.jpegData(compressionQuality: 0.1)
        }
        else if (imgSize > 1000){
            imgData=imgChose.jpegData(compressionQuality: 0.3)
        }
        else{
            imgData=imgChose.jpegData(compressionQuality: 1)
        }
        //---Avatar = imgChose
        avatarImage.image=UIImage(data: imgData)
        dismiss(animated: true, completion: nil)
    }
}
