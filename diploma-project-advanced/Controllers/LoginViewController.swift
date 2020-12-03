//
//  LoginViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 7/23/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var inptView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var errorLabelHeight0: NSLayoutConstraint!
    
    var emailTextFieldTopAnchor: NSLayoutConstraint?
    
    var match: Bool = false
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        errorLabelHeight0.priority = UILayoutPriority(rawValue: 800)
        roundCorners(view: whiteView, corners: [.topLeft, .topRight], radius: 25)
        setupInputView()
    }
    
    func setupInputView() {
        whiteView.addSubview(inptView)
        inptView.layer.cornerRadius = 6
        inptView.addSubview(emailTextField)
        inptView.addSubview(emailSeparatorView)
        inptView.addSubview(passwordTextField)
        inptView.layer.borderWidth = 1
        inptView.layer.borderColor = UIColor.init(white: 0.7, alpha: 1).cgColor
        
        //need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inptView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inptView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inptView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inptView.heightAnchor, multiplier: 1/2).isActive = true
        
        //need x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inptView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inptView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inptView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inptView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inptView.heightAnchor, multiplier: 1/2).isActive = true
        
        logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 90).isActive = true
    }
    
    func handleError() {
        errorLabelHeight0.priority = UILayoutPriority(rawValue: 700)
        inptView.layer.borderWidth = 1.5
        inptView.layer.borderColor = UIColor.red.cgColor
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        emailSeparatorView.backgroundColor = UIColor.red
    }
    
    func disableError() {
        errorLabelHeight0.priority = UILayoutPriority(rawValue: 800)
        inptView.layer.borderWidth = 1
        inptView.layer.borderColor = UIColor.init(white: 0.7, alpha: 1).cgColor
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.backgroundColor = UIColor.init(white: 0.7, alpha: 1)
    }
    
    func getToken(token: String) {
        let splashVC =  storyboard?.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        splashVC.tokenArray = TokenRealmManager.sharedInstance.getToken(tokenAPI: token)
    }
    
    func logIn(user: [String: String], userKey: String) {
        if let email = user["email"], let password = user["password"] {
            if email == self.emailTextField.text && password == self.passwordTextField.text {
                match = true
                let checkedUser = getUser(user: user)
                getToken(token: checkedUser.token!)
                emailTextField.text = ""
                passwordTextField.text = ""
                let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                vc.user = checkedUser
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                match = false
            }
        }
    }
    
    @IBAction func didTapLogInButton(_ sender: Any) {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Warning!", message: "Fill in all fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if Reachability.isConnectedToNetwork() {
            var ref: DatabaseReference!
            ref = Database.database().reference(withPath: "list")
            ref.observe(.value) { (snapshot) in
                if let users = snapshot.value as? [String: Any] {
                    if let user1 = users["user1"] as? [String: String] {
                        if !self.match {
                            self.logIn(user: user1, userKey: "user1")
                        }
                    }
                    if let user2 = users["user2"] as? [String: String] {
                        if !self.match {
                            self.logIn(user: user2, userKey: "user2")
                        }
                    }
                    if !self.match {
                        self.handleError()
                    }
                }
            }
        } else {
            internetConnectionFailedAlert()
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.disableError()
    }
}
