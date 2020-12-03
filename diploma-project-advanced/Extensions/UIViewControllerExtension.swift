//
//  UIViewControllerExtension.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/5/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIViewController {
    func roundCorners(view: UIView, corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func internetConnectionFailedAlert() {
        let alert = UIAlertController(title: "Warning!", message: "Failed Internet Connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func getUser(user: [String: String]) -> User {
        let checkedUser = User()
        checkedUser.name = user["name"]
        checkedUser.surname = user["surname"]
        checkedUser.email = user["email"]
        checkedUser.password = user["password"]
        checkedUser.age = user["age"]
        checkedUser.birthday = user["birthday"]
        checkedUser.city = user["city"]
        checkedUser.state = user["state"]
        checkedUser.zip = user["zip"]
        checkedUser.country = user["country"]
        checkedUser.phone = user["phone"]
        checkedUser.token = user["token"]
        checkedUser.latitude = Double(user["latitude"]!)
        checkedUser.longitude = Double(user["longitude"]!)
        checkedUser.keyword = user["keyword"]
        return checkedUser
    }
    
    func logout() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootVC()
        if let vc = self.navigationController?.viewControllers[0] as? LoginViewController {
            var token: [TokenRealmModel] = []
            token = Array(TokenRealmManager.sharedInstance.realm.objects(TokenRealmModel.self))
            if !token.isEmpty {
                TokenRealmManager.sharedInstance.deleteAll(array: token)
                token = []
            }
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
