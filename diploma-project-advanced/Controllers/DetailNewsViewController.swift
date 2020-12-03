//
//  DetailNewsViewController.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/1/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    var article: ArticleAPIModel?
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setupUI()
    }
    
    func setupUI() {
        roundCorners(view: whiteView, corners: [.topLeft, .topRight], radius: 25)
        websiteButton.layer.cornerRadius = 12
        imageView.layer.cornerRadius = 10
        nameLabel.text = article?.name
        imageView.load(urlString: article?.urlToImage ?? "")
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        descriptionLabel.text = article?.description
    }
    
    @IBAction func didTapWebsiteButton(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebsiteNewsViewController") as! WebsiteNewsViewController
            vc.article = article
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            internetConnectionFailedAlert()
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
