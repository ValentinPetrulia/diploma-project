
//
//  NewsRealmManager.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/9/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleRealmManager {
    
    static let sharedInstance: ArticleRealmManager = {
        let instance = ArticleRealmManager()
        return instance
    }()
    
    let realm = try! Realm()
    
    func convertFromAPIToRealm(articles: [ArticleAPIModel]) -> [ArticleRealmModel] {
        deleteAll(array: Array(realm.objects(ArticleRealmModel.self)))
        for articleAPI in articles {
            let articleRealm = ArticleRealmModel()
            articleRealm.name = articleAPI.name ?? ""
            articleRealm.author = articleAPI.author ?? ""
            articleRealm.title = articleAPI.title ?? ""
            articleRealm.dscription = articleAPI.description ?? ""
            articleRealm.url = articleAPI.url ?? ""
            articleRealm.urlToImage = articleAPI.urlToImage ?? ""
            articleRealm.publishedAt = articleAPI.publishedAt ?? ""
            writeObject(realmObject: articleRealm)
        }
        let array = Array(realm.objects(ArticleRealmModel.self))
        return array
    }
    
    func convertFromRealmToAPI() -> [ArticleAPIModel] {
        let realmArticles = Array(realm.objects(ArticleRealmModel.self))
        var articles: [ArticleAPIModel] = []
        for realmArticle in realmArticles {
            let article = ArticleAPIModel()
            article.name = realmArticle.name
            article.author = realmArticle.author
            article.title = realmArticle.title
            article.description = realmArticle.dscription
            article.url = realmArticle.url
            article.urlToImage = realmArticle.urlToImage
            article.publishedAt = realmArticle.publishedAt
            articles.append(article)
        }
        return articles
    }
    
    func writeObject(realmObject: ArticleRealmModel) {
        do {
            try realm.write {
                realm.add(realmObject)
            }
        } catch {
            print("Ooops, error!")
        }
    }
    
    func deleteAll(array: [ArticleRealmModel]) {
        if !array.isEmpty {
            try! realm.write {
                realm.delete(array)
            }
        }
    }
}


