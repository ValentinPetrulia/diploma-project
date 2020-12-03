//
//  SplashViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/5/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    var tokenArray: [TokenRealmModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        self.delay(0.5) {
            if Array(TokenRealmManager.sharedInstance.realm.objects(TokenRealmModel.self)).isEmpty {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                if Reachability.isConnectedToNetwork() {
                    var ref: DatabaseReference!
                    ref = Database.database().reference(withPath: "list")
                    ref.observe(.value) { (snapshot) in
                        if let users = snapshot.value as? [String: Any] {
                            self.checkToken(users: users, userKey: "user1")
                            self.checkToken(users: users, userKey: "user2")
                        }
                    }
                } else {
                    self.internetConnectionFailedAlert()
                }
            }
        }
        
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func checkToken(users: [String: Any], userKey: String) {
        if let user = users[userKey] as? [String: String] {
            if let token = user["token"] {
                if Array(TokenRealmManager.sharedInstance.realm.objects(TokenRealmModel.self))[0].token == token {
                    let checkedUser = getUser(user: user)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    vc.user = checkedUser
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
