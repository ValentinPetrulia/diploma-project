//
//  TokenModel.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/9/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import RealmSwift

class TokenRealmModel: Object {
    @objc dynamic var token = ""
}


class TokenRealmManager {
    static let sharedInstance: TokenRealmManager = {
        let instance = TokenRealmManager()
        return instance
    }()
    
    let realm = try! Realm()
    
    func getToken(tokenAPI: String) -> [TokenRealmModel] {
        deleteAll(array: Array(realm.objects(TokenRealmModel.self)))
        let tokenRealm = TokenRealmModel()
        tokenRealm.token = tokenAPI
        writeObject(realmObject: tokenRealm)
        let array = Array(realm.objects(TokenRealmModel.self))
        return array
    }
    
    func writeObject(realmObject: TokenRealmModel) {
        do {
            try realm.write {
                realm.add(realmObject)
            }
        } catch {
            print("Ooops, error!")
        }
    }
    
    func deleteAll(array: [TokenRealmModel]) {
        if !array.isEmpty {
            try! realm.write {
                realm.delete(array)
            }
        }
    }
}
