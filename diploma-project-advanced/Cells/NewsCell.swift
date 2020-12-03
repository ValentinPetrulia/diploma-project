//
//  NewsCell.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/1/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var imgView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(article: ArticleAPIModel) {
        titleLabel.text = article.title
        imgView.load(urlString: article.urlToImage ?? "")
    }
    
}


