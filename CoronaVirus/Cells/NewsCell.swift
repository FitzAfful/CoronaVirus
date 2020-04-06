//
//  NewsCell.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 06/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!

    var item: NewsItem? {
        didSet {
            guard let newsItem = item else { return }
            self.titleLabel.text = newsItem.title
            self.dateLabel.text = newsItem.date.timeAgoSince()
            if let url = newsItem.imageUrl {
                self.newsImageView.setImage(url: url)
            }
        }
    }
    
}
