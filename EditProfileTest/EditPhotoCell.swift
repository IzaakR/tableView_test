//
//  EditPhotoCell.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import UIKit

class EditPhotoCell: UITableViewCell {

  @IBOutlet weak var imageUser: UIImageView!
  @IBOutlet weak var imageChangePicture: UIImageView!
  var onChangePictureAction:() -> Void = {}
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  var item: EditProfileViewItem? {
    didSet {
      guard let item = item as? EditProfileViewPicture else {
        return
      }

      
      let url = URL(string: item.avatar)
      let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
      imageUser.image = UIImage(data: data!)
      
      
      
//
//      imageUser.af_setImage(withURL: url!)
//      imageUser.roundImageCustomSize2(image: imageUser, sizeCell: frame.height - 20, sizeMiddle: 2)
    }
  }
  
  func setupTapChangePicture() {
    let tapPicture = UITapGestureRecognizer(target: self, action: #selector(tapChangePicture(_:)))
    imageChangePicture.isUserInteractionEnabled = true
    imageChangePicture.addGestureRecognizer(tapPicture)
  }
  
  @IBAction func tapChangePicture(_ sender: AnyObject) {
    onChangePictureAction()
  }
  
  func createChangePictureAction (onAction: @escaping () -> Void) {
    onChangePictureAction = onAction
  }
  
  func bindNewPicture(imagen: UIImage) {
    //imageUser.image = imagen.af_imageRoundedIntoCircle()
    imageUser.image = imagen

  }
    
}
