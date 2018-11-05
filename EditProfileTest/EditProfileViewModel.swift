//
//  EditProfileViewModel.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import Foundation
import UIKit

enum EditProfileViewSections {
  case avatar
  case userMainInfo
  case emptyCell
}

protocol EditProfileViewItem {
  var type: EditProfileViewSections { get }
  var sectionTitle: String { get }
  var rowCount: Int { get }
}

class EditProfileViewPicture: EditProfileViewItem {
  var type: EditProfileViewSections {
    return .avatar
  }
  var sectionTitle: String {
    return ""
  }
  var rowCount: Int {
    return 1
  }
  var avatar: String
  init(avatar: String) {
    self.avatar = avatar
  }
}

class EditProfileViewUserInfo: EditProfileViewItem {
  var type: EditProfileViewSections {
    return .userMainInfo
  }
  var sectionTitle: String {
    return ""
  }
  var rowCount: Int {
    return optionTitle.count
  }
  var optionTitle: [String]
  var optionDetail: [String]
  init(optionTitle: [String], optionDetail: [String]) {
    self.optionTitle = optionTitle
    self.optionDetail = optionDetail
  }
}



class EditProfileEmptyCell: EditProfileViewItem {
  var type: EditProfileViewSections {
    return .emptyCell
  }
  var sectionTitle: String {
    return ""
  }
  var rowCount: Int {
    return 1
  }
}
