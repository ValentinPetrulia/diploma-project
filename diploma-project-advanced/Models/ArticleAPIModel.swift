//
//  ArticleAPIModel.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/9/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleAPIModel: Mappable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var name: String?
    
    init() {}
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        author                    <- map["author"]
        title                        <- map["title"]
        description            <- map["description"]
        url                          <- map["url"]
        urlToImage            <- map["urlToImage"]
        publishedAt          <- map["publishedAt"]
        name                     <- map["source.name"]
    }
}

class ArticleModel {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var name: String?
}
