//
//  DatePickerCell.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelDetail: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  var indexPath: IndexPath?
  var birthday: String = ""
  
  var item: EditProfileViewItem? {
    didSet {
      guard  let item = item as? EditProfileViewUserInfo else {
        return
      }
      labelTitle.text = item.optionTitle[indexPath!.row]
      labelDetail.text = item.optionDetail[indexPath!.row]
      datePicker.isHidden = true
    }
  }
  var isExpanded: Bool = false {
    didSet {
      if !isExpanded {
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        datePicker.isHidden = true
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: datePicker.date)
        labelDetail.text = dateString
        item.optionDetail.remove(at: indexPath!.row)
        item.optionDetail.insert(dateString, at: indexPath!.row)
      } else {
        //print(isExpanded, " yes editing")
        datePicker.isHidden = false
      }
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
