//
//  NewsController.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class NewsController: UIViewController {

    var manager: APIManager!
    var newsItems: [NewsItem] = []
    @IBOutlet weak var tableView: UITableView!
    var cellTag = "EmergencyCell"


    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()

        self.tableView.register(UINib(nibName: cellTag, bundle: nil), forCellReuseIdentifier: cellTag)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()

        if let dictionary = UserDefaults.standard.dictionary(forKey: "news") {
            if let object = try? DictionaryDecoder().decode(NewsResponse.self, from: dictionary){
                self.newsItems = object.data
                self.tableView.reloadData()
            }
        }
        self.getNews()
    }

    func getNews(){
        manager = APIManager()
        manager.getNews { (result) in
            switch result {
            case .success(let myFeed):
                if let rss = myFeed.rssFeed {
                    self.newsItems = rss.items!.map { (item)  in
                        return NewsItem(title: item.title!, description: item.description!, link: item.link!, date: item.pubDate!)
                    }
                    let response = NewsResponse(data: self.newsItems)
                    UserDefaults.standard.set(response.dictionary, forKey: "news")
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.failureReason!)")
                self.showAlert(withTitle: "Error", message: error.failureReason!)
            }
        }
    }
}


extension NewsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTag, for: indexPath) as! EmergencyCell
        cell.item = self.newsItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
