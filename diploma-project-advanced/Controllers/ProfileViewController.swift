//
//  ProfileViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 7/23/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController {

    var user = User()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setupButtons()
        showInfo()
    }
    
    func setupButtons() {
        phoneButton.layer.cornerRadius = 12
        emailButton.layer.cornerRadius = 12
        logoutButton.layer.cornerRadius = 12
    }
    
    func showInfo() {
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        ageLabel.text =  (user.age ?? "") + " y.o."
        birthdayLabel.text = user.birthday
        cityLabel.text = user.city
        stateLabel.text = user.state
        countryLabel.text = user.country
        zipLabel.text = user.zip
        phoneButton.setTitle(user.phone, for: .normal)
        emailButton.setTitle(user.email, for: .normal)
    }
    
    @IBAction func didTapPhoneButton(_ sender: Any) {
        sendMessage(to: user)
    }
    
    @IBAction func didTapEmailButton(_ sender: Any) {
        sendMail(to: user)
    }
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
        logout()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProfileViewController: MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendMessage(to user: User) {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let messageCompose = MFMessageComposeViewController()
        messageCompose.messageComposeDelegate = self
        messageCompose.recipients = (([user.phone] ) as! [String])
        messageCompose.body = "Hello there"
        messageCompose.subject = "Test"
        present(messageCompose, animated: true, completion: nil)
    }
    
    func sendMail(to user: User) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([user.email!])
        composer.setSubject("Hello there")
        composer.setMessageBody("Test", isHTML: false)
        present(composer, animated: true)
    }
}
