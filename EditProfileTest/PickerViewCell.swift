//
//  PickerViewCell.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import UIKit

class PickerViewCell: UITableViewCell {
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelDetail: UILabel!
  @IBOutlet weak var pickerView: UIPickerView!
  var isGender = false
  var country: String = ""
  var gender: String = ""
  let genderType = ["Male", "Famale", "Not Specified"]
  let contries = ["Afganistán",
                  "Albania",
                  "Alemania",
                  "Andorra",
                  "Angola",
                  "Antigua y Barbuda",
                  "Arabia Saudita",
                  "Argelia",
                  "Argentina",
                  "Armenia"]
  var indexPath: IndexPath?
  var item: EditProfileViewItem? {
    didSet {
      guard  let item = item as? EditProfileViewUserInfo else {
        return
      }
      labelTitle.text = item.optionTitle[indexPath!.row]
      labelDetail.text = item.optionDetail[indexPath!.row]
      pickerView.isHidden = true
      labelDetail.isHidden = false
    }
  }
  var isExpanded: Bool = false {
    didSet {
      if !isExpanded {
        // no is editing
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        pickerView.isHidden = true
        if isGender == false {
          item.optionDetail.remove(at: indexPath!.row)
          item.optionDetail.insert(country, at: indexPath!.row)
        } else {
          item.optionDetail.remove(at: indexPath!.row)
          item.optionDetail.insert(gender, at: indexPath!.row)
        }
      } else {
        // yes editing
        pickerView.isHidden = false
        labelDetail.isHidden = false
        guard  let item = item as? EditProfileViewUserInfo else {
          return
        }
        if isGender == false {
          country = item.optionDetail[indexPath!.row]
        } else {
          gender = item.optionDetail[indexPath!.row]
        }
      }
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    pickerView.delegate = self
    pickerView.dataSource = self
    // Initialization code
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}

extension PickerViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if isGender == false {
      return contries.count
    } else {
      return genderType.count
    }
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if isGender == false {
      return contries[row]
    } else {
      return genderType[row]
    }
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if isGender == false {
      labelDetail.text = contries[row]
      country = contries[row]
    } else {
      labelDetail.text = genderType[row]
      gender = genderType[row]
    }
  }

}
