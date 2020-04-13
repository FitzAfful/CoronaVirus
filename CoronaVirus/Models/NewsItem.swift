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
    var imageUrl: URL? = nil

    init(title:String, description: String, link: String, date: Date) {
        self.title = title
        self.description = description
        self.link = link
        self.date = date
        if description.components(separatedBy: "?sfvrsn").count > 1 {
            let firstImageString = description.components(separatedBy: "?sfvrsn")[0]
            if(firstImageString.components(separatedBy: "src=\"").count > 1){
                let imageString = firstImageString.components(separatedBy: "src=\"")[1]
                self.imageUrl = URL(string: imageString)
            }
        }
        print(link)
        print("*********************************************************************")
        print(" ")
    }

    public static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        return (lhs.link == rhs.link)
    }
}

public class NewsResponse : Codable {
    var data: [NewsItem]

    init(data: [NewsItem]) {
        self.data = data
    }
}
