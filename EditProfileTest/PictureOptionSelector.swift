//
//  PictureOptionSelector.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import Foundation
import  UIKit
class PictureOptionSelector: UIAlertController {
  
  let imagePicker = UIImagePickerController()
  weak var parentController: UIViewController?
  
  convenience init(title: String, parentController: UIViewController) {
    self.init(title: "Change Profile Photo",
              message: "",
              preferredStyle: .actionSheet)
    self.parentController = parentController
    addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
    setupActions()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupActions() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
      addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) -> Void in
        self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.imagePicker.allowsEditing = true
        self.parentController?.present(self.imagePicker, animated: true, completion: nil)
      }))
    }
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
      addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) -> Void in
        self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.imagePicker.allowsEditing = true
        self.parentController?.present(self.imagePicker, animated: true, completion: nil)
      }))
    }
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
}
