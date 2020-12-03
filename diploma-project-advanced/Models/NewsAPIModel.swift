//
//  NewsAPIModel.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/2/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsAPIModel: Mappable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleAPIModel] = []
    
    required init?(map: Map) {
        do {
            self.status =  try map.value("status")
        } catch {
            print("No Status Present")
        }
    }
    
    func mapping(map: Map) {
        totalResults        <- map["totalResults"]
        articles               <- map["articles"]
    }
    
}
