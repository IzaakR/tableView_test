//
//  ViewController.swift
//  EditProfileTest
//
//  Created by Isaac on 11/1/18.
//  Copyright © 2018 Mudpie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
  var items = [EditProfileViewItem]()
  var imageLoad: UIImage!
  var isChangePicture = false
  var about = ""
  var location = ""
  var phoneNumber = ""
  var email = ""
  var name = ""
  var username = ""
  var gender = ""
  var birthday = ""
  var picture: Data?
  var rowSelected: IndexPath!
  
  let user = User(about: "No Tengo Nada",
                  avatar: "https://s3.amazonaws.com/stage.mudpie.mx/uploads/user/avatars/5/original-aac6b18f-d15b-4cad-856b-a8d265dc32f0.jpg",
                  birthday: "",
                  email: "izaak@live.co.kr",
                  gender: "Male",
                  userId: 25,
                  location: "Mexico",
                  name: "Isaac R",
                  phoneNumber: "5526892662",
                  score: 5,
                  username: "izaak",
                  website: "www.google.com")
  
  @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "EditPhotoCell", bundle: nil), forCellReuseIdentifier: "EditPhotoCell")
    tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    tableView.register(UINib(nibName: "TextViewCell", bundle: nil), forCellReuseIdentifier: "TextViewCell")
    tableView.register(UINib(nibName: "PickerViewCell", bundle: nil), forCellReuseIdentifier: "PickerViewCell")
    tableView.register(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "DatePickerCell")
    tableView.register(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "BusinessCell")
    tableView.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    tableView.register(UINib(nibName: "ImageAndLabelCell", bundle: nil), forCellReuseIdentifier: "ImageAndLabelCell")
    
    tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
   
    bindUserData(user: user)
    notiticationKeyboard()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func bindUserData(user: User) {
    let avatar = user.avatar
    let picture = EditProfileViewPicture(avatar: avatar!)
    let url: URL = URL(string: user.avatar!)!
    guard let data = try? Data(contentsOf: url) else {return}
    imageLoad = UIImage(data: data)
    items.append(picture)
    let title = ["Name", "Usename", "About me", "Gender", "Birthday", "City", "Email", "Phone number"]
    let detail: [String] = [user.name!, user.username!,
                            user.about!, user.gender!,
                            user.birthday!, user.location!,
                            user.email!, user.phoneNumber!]
    let userInfo = EditProfileViewUserInfo(optionTitle: title, optionDetail: detail)
    items.append(userInfo)
    let emptycell = EditProfileEmptyCell()
    items.append(emptycell)
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  override func viewWillAppear(_ animated: Bool) {
    if isChangePicture == true {
      let indexPath = IndexPath(row: 0, section: 0)
      self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
      isChangePicture = false
    }
  }
  
  @IBAction func back(_ sender: Any) {
    self.dismiss(animated: true) {}
  }
  
  
  func notiticationKeyboard() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleKeyboardNotification),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleKeyboardNotification),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  //Open keyboard
  @objc func handleKeyboardNotification(notification: NSNotification) {
    if notification.userInfo != nil {
      let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
      let sizeKeyboard: CGFloat = keyboardSize!.height + 10
      UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
        // add code size tableview
        self.tableViewBottom.constant = isKeyboardShowing ? sizeKeyboard: 10
       // self.tableViewHeight.constant =  isKeyboardShowing ? self.view.frame.height + sizeKeyboard: self.view.frame.height - sizeKeyboard
        self.view.layoutIfNeeded()
      }, completion: {_ in
        if isKeyboardShowing {
          // add code animation row
        }
      })
    }
  }
  
  
  func animateToRow() {
      self.tableView.scrollToRow(at: rowSelected,
                                 at: UITableView.ScrollPosition.bottom,
                                 animated: true)
    
  }
  
  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return items.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items[section].rowCount
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.section]
    switch item.type {
    case .avatar:
      return pictureCell(indexPath: indexPath, item: item)
    case .userMainInfo:
      return userInfoCell(indexPath: indexPath, item: item)
    case .emptyCell:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as? EmptyCell else {fatalError(" no es una tabla")}
      return cell
    }
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let item = items[indexPath.section]
    switch item.type {
    case .avatar:
      return 163
    case .userMainInfo:
      return tableView.rowHeight
    case .emptyCell:
      return 600
    }
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let item = items[section].sectionTitle
    return item
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    rowSelected = indexPath
    let item = items[indexPath.section]
    switch item.type {
    case .avatar:
      break
    case .userMainInfo:
      userInfodidSelectRow(indexPath: indexPath)
    case .emptyCell:
      break
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let item = items[indexPath.section]
    switch item.type {
    case .avatar:
      break
    case .userMainInfo:
      userInfodidDeselect(indexPath: indexPath)
    case .emptyCell:
      break
    }
  }
  
  func pictureCell(indexPath: IndexPath, item: EditProfileViewItem) -> EditPhotoCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "EditPhotoCell", for: indexPath) as? EditPhotoCell
    cell?.item = item
    cell?.setupTapChangePicture()
    cell?.createChangePictureAction {
      self.imageTapped()
    }
    if isChangePicture == true {
      cell?.bindNewPicture(imagen: imageLoad)
      self.picture = imageLoad.jpegData(compressionQuality: 0.25)!
    } else {
      cell?.bindNewPicture(imagen: imageLoad)
      self.picture = imageLoad.jpegData(compressionQuality: 0.25)!
    }
    return cell!
  }
  
  func imageTapped() {
    let pictureSource = PictureOptionSelector(title: "Change Profile Photo", parentController: self)
    pictureSource.imagePicker.delegate = self
    self.present(pictureSource, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    // Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
    
    if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(
      UIImagePickerController.InfoKey.editedImage)] as? UIImage {
      imageLoad = pickedImage
      isChangePicture = true
    } else if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(
      UIImagePickerController.InfoKey.originalImage)] as? UIImage {
      imageLoad = pickedImage
      isChangePicture = true
    }
    self.dismiss(animated: true, completion: nil)
  }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) ->
  [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
  return input.rawValue
}




extension ViewController {
  func userInfoCell(indexPath: IndexPath, item: EditProfileViewItem) -> UITableViewCell {
    switch indexPath.row {
    case 2:
      let aboutCell = textViewCell(indexPath: indexPath, item: item)
      return aboutCell
    case 3:
      let genderCell = pickerViewCell(indexPath: indexPath, item: item)
      return genderCell
    case 4:
      let birthdayCell = datePickerCell(indexPath: indexPath, item: item)
      return birthdayCell
    case 5:
      let locationCell = pickerViewCell(indexPath: indexPath, item: item)
      return locationCell
    default:
      let groupTextfiel = textFieldCell(indexPath: indexPath, item: item)
      return groupTextfiel
    }
  }
  func pickerViewCell(indexPath: IndexPath, item: EditProfileViewItem) -> PickerViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "PickerViewCell", for: indexPath)
      as? PickerViewCell
    cell?.indexPath = indexPath
    cell?.item = item
    if indexPath.row == 3 {
      cell?.isGender = true
      self.gender = cell!.labelDetail.text!
    } else {
      cell?.isGender = false
      self.location = cell!.labelDetail.text!
    }
    return cell!
  }
  
  func textViewCell(indexPath: IndexPath, item: EditProfileViewItem) -> TextViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath)
      as? TextViewCell
    cell?.indexPath = indexPath
    cell?.item = item
    self.about = cell!.labelDetail.text!
    return cell!
  }
  func datePickerCell(indexPath: IndexPath, item: EditProfileViewItem) -> DatePickerCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath)
      as? DatePickerCell
    cell?.indexPath = indexPath
    cell?.item = item
    self.birthday = cell!.labelDetail.text!
    return cell!
  }
  func textFieldCell(indexPath: IndexPath, item: EditProfileViewItem) -> TextFieldCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath)
      as? TextFieldCell
    cell?.indexPath = indexPath
    cell?.item = item
    userDataTextFiel(cell: cell!, indexPath: indexPath)
    cell?.closeKeyboardAction {
      self.userDataTextFiel(cell: cell!, indexPath: indexPath)
      cell?.isExpanded = false
    }
    return cell!
  }
  func userDataTextFiel(cell: TextFieldCell, indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      self.name = cell.labelDetail.text!
      cell.textFieldEdit.keyboardType = .default
    case 1:
      self.username = cell.labelDetail.text!
      cell.textFieldEdit.keyboardType = .default
    case 6:
      self.email = cell.labelDetail.text!
      cell.textFieldEdit.keyboardType = .emailAddress
    case 7:
      self.phoneNumber = cell.labelDetail.text!
      cell.textFieldEdit.keyboardType = .numberPad
    default:
      break
    }
  }
  
  func userInfodidSelectRow(indexPath: IndexPath) {
    switch indexPath.row {
    case 2:
      didSelectTextView(indexPath: indexPath)
    case 3:
      didSelectPickerView(indexPath: indexPath)
    case 4:
      didSelectDatePicker(indexPath: indexPath)
    case 5:
      didSelectPickerView(indexPath: indexPath)
    default:
      didSelectTextField(indexPath: indexPath)
    }
  }
  func didSelectTextView(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? TextViewCell  else {return}
    cell.isExpanded = !cell.isExpanded
    self.about = cell.labelDetail.text!
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  func didSelectDatePicker(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? DatePickerCell  else {return}
    cell.isExpanded = !cell.isExpanded
    self.birthday = cell.labelDetail.text!
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  func didSelectPickerView(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? PickerViewCell  else {return}
    cell.isExpanded = !cell.isExpanded
    if indexPath.row == 3 {
      cell.isGender = true
      self.gender = cell.labelDetail.text!
    } else {
      cell.isGender = false
      self.location = cell.labelDetail.text!
    }
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  func didSelectTextField(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? TextFieldCell  else {return}
    cell.isExpanded = !cell.isExpanded
    switch indexPath.row {
    case 0:
      self.name = cell.labelDetail.text!
    case 1:
      self.username = cell.labelDetail.text!
    case 6:
      self.email = cell.labelDetail.text!
    case 7:
      self.phoneNumber = cell.labelDetail.text!
    default:
      break
    }
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  
  func userInfodidDeselect(indexPath: IndexPath) {
    switch indexPath.row {
    case 2:
      didDeselectTextView(indexPath: indexPath)
    case 3:
      didDeselectPickerView(indexPath: indexPath)
    case 4:
      didDeselectDatePicker(indexPath: indexPath)
    case 5:
      didDeselectPickerView(indexPath: indexPath)
    default:
      didDeselectTextField(indexPath: indexPath)
    }
  }
  func didDeselectTextView(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? TextViewCell  else {return}
    cell.isExpanded = false
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  func didDeselectDatePicker(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? DatePickerCell  else {return}
    cell.isExpanded = false
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  func didDeselectPickerView(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? PickerViewCell  else {return}
    cell.isExpanded = false
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
  func didDeselectTextField(indexPath: IndexPath) {
    guard let cell = self.tableView.cellForRow(at: indexPath) as? TextFieldCell  else {return}
    cell.isExpanded = false
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
  }
}
