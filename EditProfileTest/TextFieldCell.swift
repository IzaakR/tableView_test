//
//  TextFieldCell.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextFieldDelegate {
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelDetail: UILabel!
  @IBOutlet weak var textFieldEdit: UITextField!
  var onCloseKeyboard:() -> Void = {}
  var indexPath: IndexPath?
  var item: EditProfileViewItem? {
    didSet {
      guard  let item = item as? EditProfileViewUserInfo else {
        return
      }
      labelTitle.text = item.optionTitle[indexPath!.row]
      labelDetail.text = item.optionDetail[indexPath!.row]
      textFieldEdit.isHidden = true
    }
  }
  var isExpanded: Bool = false {
    didSet {
      if !isExpanded {
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        // no is editing
        textFieldEdit.isHidden = true
        labelDetail.isHidden = false
        textFieldEdit.resignFirstResponder()
        item.optionDetail.remove(at: indexPath!.row)
        item.optionDetail.insert(textFieldEdit.text!, at: indexPath!.row)
        labelDetail.text = textFieldEdit.text!
      } else {
        //yes editing
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        textFieldEdit.isHidden = false
        labelDetail.isHidden = true
        textFieldEdit.text = item.optionDetail[indexPath!.row]
        textFieldEdit.becomeFirstResponder()
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    textFieldEdit.delegate = self
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    onCloseKeyboard()
    return true
  }
  
  func closeKeyboardAction(onAction: @escaping() -> Void) {
    onCloseKeyboard = onAction
  }
}
