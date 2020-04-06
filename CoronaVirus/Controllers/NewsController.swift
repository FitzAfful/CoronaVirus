//
//  NewsController.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import SafariServices

class NewsController: UIViewController {

    var manager: APIManager!
    var newsItems: [NewsItem] = []
    @IBOutlet weak var tableView: UITableView!
    var cellTag = "NewsCell"
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()

        self.tableView.register(UINib(nibName: cellTag, bundle: nil), forCellReuseIdentifier: cellTag)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()

        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)


        if let dictionary = UserDefaults.standard.dictionary(forKey: "news") {
            if let object = try? DictionaryDecoder().decode(NewsResponse.self, from: dictionary){
                self.newsItems = object.data
                self.tableView.reloadData()
            }
        }
        self.getNews()
    }

    @objc func refreshTable(toRefresh sender: UIRefreshControl?) {
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
                    self.refreshControl.endRefreshing()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTag, for: indexPath) as! NewsCell
        cell.item = self.newsItems[indexPath.row]
        if let url = self.newsItems[indexPath.row].imageUrl {
            cell.newsImageView.contentMode = .scaleToFill
            cell.newsImageView.setImage(url: url)
            cell.newsImageView.contentMode = .scaleToFill
        }else {
            cell.newsImageView.image = nil
            cell.newsImageView.contentMode = .scaleAspectFit
            cell.newsImageView.image = UIImage(named: "icons8-news-1")
            cell.newsImageView.contentMode = .scaleAspectFit
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = self.newsItems[indexPath.row].link
        if let url = URL(string: link) {
            let vc1 = SFSafariViewController(url: url)
            self.present(vc1, animated: true)
        }
    }
}
