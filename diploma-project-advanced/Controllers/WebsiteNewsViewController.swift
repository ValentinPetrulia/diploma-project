//
//  WebsiteNewsViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/4/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class WebsiteNewsViewController: UIViewController {
    
    var article: ArticleAPIModel?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        if let url = URL(string: article!.url!) {
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
