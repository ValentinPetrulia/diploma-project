//
//  UIImageViewExtension.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/4/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import UIKit

//let imageCache = NSCache<NSString, UIImage>()
//
//class CustomImageView: UIImageView {
//
//    var imageUrlString: String?
//
//    func loadImage(urlString: String) {
//        image = nil
//        imageUrlString = urlString
//        let urlNSString = NSString(string: urlString)
//        let url = URL(string: urlString)
//
//        if let imageFromCache = imageCache.object(forKey: urlNSString) {
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil {
//                print(error as Any)
//                return
//            }
//
//            DispatchQueue.main.async {
//                if let imageToCache = UIImage(data: data!) {
//                    imageCache.setObject(imageToCache, forKey: urlNSString)
//                    self.image = imageToCache
//                }
//
//            }
//        }
//
//    }
//
//}


let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func load(urlString: String) {
        image = nil
        imageUrlString = urlString
        let urlNSString = NSString(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlNSString) {
            self.image = imageFromCache
            return
        }
        
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if let imageToCache = UIImage(data: data) {
                            imageCache.setObject(imageToCache, forKey: urlNSString)
                            self?.image = imageToCache
                        }
                    }
                }
            }
        }
    }
}

//extension UIImageView {
//    func load(urlString: String) {
//        image = nil
//        if let url = URL(string: urlString) {
//            DispatchQueue.global().async { [weak self] in
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self?.image = image
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
