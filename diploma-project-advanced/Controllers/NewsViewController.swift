//
//  NewsViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/1/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class NewsViewController: UIViewController {
    
    var user = User()
    
    var totalArticles: [ArticleAPIModel] = []
    var realmArticles: [ArticleRealmModel] = []
    
    var counter = 1
    var searchModel = SearchModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        getNewsFromAPI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        if !Reachability.isConnectedToNetwork() {
            totalArticles = ArticleRealmManager.sharedInstance.convertFromRealmToAPI()
        }
        // Do any additional setup after loading the view.
    }
    
    func getNewsFromAPI() {
        let searchModel = SearchModel()
        var parameters: [String: Any] = [:]
        parameters["q"] = user.keyword
        parameters["apiKey"] = "e04639a4227f4659b4c0ce967b1adf93"
        parameters["from"] = "2019-07-25"
        parameters["to"] = "2019-08-02"
        parameters["pageSize"] = "\(searchModel.pageSize)"
        parameters["page"] = "\(counter)"
        
        Alamofire.request("https://newsapi.org/v2/everything", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            let news = Mapper<NewsAPIModel>().map(JSONObject: response.result.value)
            if let articles = news?.articles {
                self.totalArticles += articles
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.update(article: totalArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
        vc.article = totalArticles[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:IndexPath) {
        if canLoadNextPage(current: indexPath.row, total: totalArticles.count) {
            if Reachability.isConnectedToNetwork() {
                counter += 1
                getNewsFromAPI()
                realmArticles = ArticleRealmManager.sharedInstance.convertFromAPIToRealm(articles: totalArticles)
            } else {
                totalArticles = ArticleRealmManager.sharedInstance.convertFromRealmToAPI()
            }
        }
    }
    
    func canLoadNextPage(current: Int, total: Int) -> Bool{
        guard current + 1 >= total else {
            return false
        }
        return total < searchModel.maxPageSize
    }
}
