//
//  User.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import Foundation

class User {
  var about: String?
  var avatar: String?
  var birthday: String?
  var email: String?
  var gender: String?
  var userId = 0
  var location: String?
  var name: String?
  var phoneNumber: String?
  var score = 0
  var username: String?
  var website: String?
  
  init() {
    
  }
  
  init (about: String, avatar: String, birthday: String, email: String, gender: String, userId: Int
  , location: String, name: String, phoneNumber: String, score: Int, username: String, website: String) {
  self.about = about
    self.avatar = avatar
    self.birthday = birthday
    self.email = email
    self.gender = gender
    self.userId = userId
    self.location = location
    self.name = name
    self.phoneNumber = phoneNumber
    self.score = score
    self.username = username
    self.website = website
  }
}
