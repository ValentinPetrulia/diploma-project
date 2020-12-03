//
//  NewsRealmModel.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/2/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleRealmModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var dscription = ""
    @objc dynamic var url = ""
    @objc dynamic var urlToImage = ""
    @objc dynamic var publishedAt = ""
}
