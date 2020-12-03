//
//  StringExtension.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/5/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation

extension String {
    
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
