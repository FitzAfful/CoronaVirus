//
//  NewsCell.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 06/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    var item: NewsItem? {
        didSet {
            guard let newsItem = item else { return }
            self.titleLabel.text = newsItem.title
            self.descriptionLabel.text = newsItem.details
            self.dateLabel.text = 
        }
    }
    
}
