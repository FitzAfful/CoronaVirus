//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public class NewsItem : Codable, Equatable {
    var title: String
    var description: String
    var link: String
    var date: Date

    init(title:String, description: String, link: String, date: Date) {
        self.title = title
        self.description = description
        self.link = link
        self.date = date
    }

    public static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        return (lhs.link == rhs.link)
    }

    var imageUrl: URL? {
        if description.components(separatedBy: "\" alt=\"").count > 1 {
            let firstImageString = description.components(separatedBy: "\" alt=\"")[0]
            let imageString = firstImageString.components(separatedBy: "src=\"")[1]
            return URL(string: imageString)
        }
        return nil
    }
}

public class NewsResponse : Codable {
    var data: [NewsItem]

    init(data: [NewsItem]) {
        self.data = data
    }
}

