//
//  TextViewCell.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell, UITextViewDelegate {
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelDetail: UILabel!
  @IBOutlet weak var textViewEdit: UITextView!
  @IBOutlet weak var labelTextViewCount: UILabel!
  var indexPath: IndexPath?
  var item: EditProfileViewItem? {
    didSet {
      guard  let item = item as? EditProfileViewUserInfo else {
        return
      }
      labelTitle.text = item.optionTitle[indexPath!.row]
      labelDetail.text = item.optionDetail[indexPath!.row]
      textViewEdit.isHidden = true
      labelTextViewCount.isHidden = true
      contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
  }
  var isExpanded: Bool = false {
    didSet {
      if !isExpanded {
        // no is editing
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        textViewEdit.isHidden = true
        labelDetail.isHidden = false
        labelTextViewCount.isHidden = true
        labelDetail.text = textViewEdit.text
        textViewEdit.resignFirstResponder()
        item.optionDetail.remove(at: indexPath!.row)
        item.optionDetail.insert(textViewEdit.text!, at: indexPath!.row)
      } else {
        // yes editing
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        textViewEdit.isHidden = false
        textViewEdit.text = item.optionDetail[indexPath!.row]
        labelDetail.isHidden = true
        textViewEdit.becomeFirstResponder()
        labelTextViewCount.isHidden = false
        labelTextViewCount.text = String(140 - textViewEdit.text.count)
      }
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    textViewEdit.delegate = self
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if textView == textViewEdit {
      var newString = textView.text as NSString?
      newString  = newString?.replacingCharacters(in: range, with: text) as NSString?
      if  textView.text.count == 140 && text != "" || newString!.length > 140 {
        return false
      }
      labelTextViewCount.text = String(140 - newString!.length)
    }
    return true
  }
}
