//
//  ProfileViewController.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 01/02/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SettingsVCDelegate: AnyObject {

  func reloadUsername()

}

protocol ProfileDisplayLogic: AnyObject {

  func displayUsername(viewModel: UserInfo.FetchUsername.ViewModel)
  func displayConfigurationOfDarkModeSwitcher(viewModel: UserInfo.CheckDarkMode.ViewModel)
  func displayUserPick(viewModel: UserInfo.FetchUserPick.ViewModel)
  func displayUserStats(viewModel: UserInfo.FetchStats.ViewModel)

}

class ProfileViewController: UIViewController, ProfileDisplayLogic {

  var interactor: ProfileBusinessLogic?
  weak var delegate: SettingsVCDelegate?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup
  
  private func setup() {

    let viewController = self
    let interactor = ProfileInteractor()
    let presenter = ProfilePresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController

  }

  // MARK: View lifecycle

  var circularView: CircularProgressView!
  var imagePicker: ImagePicker!

  var darkModeOn: Bool?
  var percentageOfCompleteTasks: Double?

  @IBOutlet weak var userPick: UIImageView!
  @IBOutlet weak var completedPercentage: UILabel!

  @IBOutlet weak var allTasksLabel: UILabel!
  @IBOutlet weak var activeTasksLabel: UILabel!
  @IBOutlet weak var completedTasksLabel: UILabel!

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var leftItemOfGrid: UIView!
  @IBOutlet weak var rightItemOfGrid: UIView!
  @IBOutlet weak var centralItemOfGrid: UIView!
  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var allowReminders: UISwitch!
  @IBOutlet weak var darkMode: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    username.delegate = self

    fetchUsername()

    configUI()
  }


  // MARK: Do something

  func configUserPicturePicker() {

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    userPick.isUserInteractionEnabled = true
    userPick.addGestureRecognizer(tapGestureRecognizer)
    imagePicker = ImagePicker(presentationController: self, delegate: self)

  }

  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    self.imagePicker.present(from: self.view)
  }


  func configUI() {

    configUserPicturePicker()
    fetchUserPick()
    userPick.makeRounded()
    fetchStats()
    checkDarkMode()

    // check whether darkmode is on or not
    if let darkMode = darkModeOn {

      if darkMode {
        self.darkMode.isOn = true
      } else {
        self.darkMode.isOn = false
      }

    }

    username.returnKeyType = .done

    self.pushEnabledAtOSLevel() { isOn in

      DispatchQueue.main.async {
        if isOn {
          self.allowReminders.isOn = true
        } else {
          self.allowReminders.isOn = false
        }

      }
    }

    leftItemOfGrid.layer.cornerRadius = 10
    rightItemOfGrid.layer.cornerRadius = 10
    centralItemOfGrid.layer.cornerRadius = 10

    circularView = CircularProgressView()

    configCircularProgressView()

  }

  func configCircularProgressView() {

    containerView.addSubview(circularView)

    circularView.translatesAutoresizingMaskIntoConstraints = false

    view.addConstraint(NSLayoutConstraint(item: circularView!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))

    view.addConstraint(NSLayoutConstraint(item: circularView!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))

    circularView.progressAnimation(duration: 1,
                                   toValue: percentageOfCompleteTasks ?? 0.0)
  }
  
  func fetchUsername() {

    let request = UserInfo.FetchUsername.Request(userDefaultsKey: "username")

    interactor?.fetchUsername(request: request)
  }

  func displayUsername(viewModel: UserInfo.FetchUsername.ViewModel) {

    username.text = viewModel.username

  }

  func fetchUserPick() {

    let fileName = "userPick.jpg"

    let request = UserInfo.FetchUserPick.Request(fileName: fileName)

    interactor?.fetchUserPick(request: request)

  }

  func checkDarkMode() {

    let request = UserInfo.CheckDarkMode.Request(userDefaultsKey: "darkModeEnabled")

    interactor?.checkDarkMode(request: request)

  }

  func displayConfigurationOfDarkModeSwitcher(viewModel: UserInfo.CheckDarkMode.ViewModel) {

    darkModeOn = viewModel.isOn

  }

  func fetchStats() {

    let request = UserInfo.FetchStats.Request()

    interactor?.fetchUserStats(request: request)

  }

  func displayUserStats(viewModel: UserInfo.FetchStats.ViewModel) {

    allTasksLabel.text = viewModel.stats.numberOfAllTasks
    completedTasksLabel.text = viewModel.stats.numberOfCompletedTasks
    activeTasksLabel.text = viewModel.stats.numberOfActiveTasks

    percentageOfCompleteTasks = viewModel.stats.percentage

    completedPercentage.text = "\(Int(percentageOfCompleteTasks ?? 0.0))%"

  }

  func changeDarkMode() {

    let request = UserInfo.ChangeDarkMode.Request(userDefaultsKey: "darkModeEnabled")

    interactor?.changeDarkMode(request: request)

  }

  func openSettings() {

    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    }

    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
        print("Settings opened: \(success)")
      })
    }

  }

  func pushEnabledAtOSLevel(completion: @escaping(Bool) -> ()) {
    let current = UNUserNotificationCenter.current()

    current.getNotificationSettings(completionHandler: { (settings) in
      if settings.authorizationStatus == .notDetermined {
        completion(false)
      } else if settings.authorizationStatus == .denied {
        completion(false)
      } else if settings.authorizationStatus == .authorized {
        completion(true)
      }
    })
  }

  @IBAction func onClickAllowReminders(_ sender: UISwitch) {

    openSettings()

  }

  @IBAction func onClickDarkMode(_ sender: UISwitch) {

   changeDarkMode()

  }
}


extension ProfileViewController: ImagePickerDelegate {

  func didSelect(image: UIImage?) {
    changeImage(image: image)
    fetchUserPick()
  }

  func changeImage(image: UIImage?) {

    if let image = image {

      let request = UserInfo.ChangeUserPick.Request(image: image)

      interactor?.changeUserPick(request: request)
    }

  }

  func displayUserPick(viewModel: UserInfo.FetchUserPick.ViewModel) {

    userPick.image = viewModel.image

  }
}

extension ProfileViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    saveUserName(username: textField.text)
    delegate?.reloadUsername()
    self.username.endEditing(true)
    return false

  }

  func saveUserName(username: String?) {

    if let username = username {
      let request = UserInfo.ChangeUsername.Request(newUserName: username,
                                                    userDefaultsKey: "username")

      interactor?.changeUsername(request: request)

    }
  }
}

