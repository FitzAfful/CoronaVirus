//
//  HomeController.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import SafariServices

class HomeController: UITableViewController {

    @IBOutlet weak var ghanaConfirmedLabel: UILabel!
    @IBOutlet weak var ghanaCriticalLabel: UILabel!
    @IBOutlet weak var ghanaDeadLabel: UILabel!
    @IBOutlet weak var ghanaRecoveredLabel: UILabel!

    @IBOutlet weak var globalConfirmedLabel: UILabel!
    @IBOutlet weak var globalDeadLabel: UILabel!
    @IBOutlet weak var globalRecoveredLabel: UILabel!

    @IBOutlet weak var loader: UIActivityIndicatorView!
    var statistics: NewGlobalStat!
    var ghStatistics: GhanaStatResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()

        self.refreshControl = UIRefreshControl()
        self.tableView.addSubview(self.refreshControl!)
        self.tableView.alwaysBounceVertical = true
        self.refreshControl?.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)
        
        if let dictionary = UserDefaults.standard.dictionary(forKey: "stats") {
            if let object = try? DictionaryDecoder().decode(NewGlobalStat.self, from: dictionary){
                self.statistics = object
                self.setGlobalStatistics()
            }
        }

        if let dictionary = UserDefaults.standard.dictionary(forKey: "gh-stats") {
            if let object = try? DictionaryDecoder().decode(GhanaStatResponse.self, from: dictionary){
                self.ghStatistics = object
                self.setGhanaStatistics()
            }
        }

        self.getStatistics()
    }

    @objc func refreshTable(toRefresh sender: UIRefreshControl?) {
        self.getStatistics()
    }

    @IBAction func viewOffers(_ sender: Any) {
        let link = "https://technationgh.com/stay-at-home-offers/"
        if let url = URL(string: link) {
            let vc1 = SFSafariViewController(url: url)
            self.present(vc1, animated: true)
        }
    }

    func getStatistics(){
        self.loader.isHidden = false
        self.loader.startAnimating()
        /*APIManager().getSummaryStats { (result) in
            switch result.result {
            case.success(let response):
                UserDefaults.standard.set(response.dictionary, forKey: "stats")
                self.statistics = response
                self.setGlobalStatistics()
                self.tableView.refreshControl?.endRefreshing()
            case .failure:
            self.loader.isHidden = true
                self.showAlert(withTitle: "Error", message: "Could not retrieve latest statistics. Please try again later.")
            }
        }*/

        APIManager().getNewSummaryStats { (result) in
            switch result.result {
                case.success(let response):
                    UserDefaults.standard.set(response.data.dictionary, forKey: "stats")
                    self.statistics = response.data
                    self.setGlobalStatistics()
                    self.tableView.refreshControl?.endRefreshing()
                case .failure:
                self.loader.isHidden = true
                    self.showAlert(withTitle: "Error", message: "Could not retrieve latest statistics. Please try again later.")
                }
            }

        APIManager().getGhanaStats { (result) in
            switch result.result {
            case.success(let response):
                UserDefaults.standard.set(response.dictionary, forKey: "gh-stats")
                self.ghStatistics = response
                self.loader.isHidden = true
                self.setGhanaStatistics()
                self.tableView.refreshControl?.endRefreshing()
            case .failure:
            self.loader.isHidden = true
                self.showAlert(withTitle: "Error", message: "Could not retrieve latest Ghanaian statistics. Please try again later.")
            }
        }
    }

    func setGlobalStatistics(){
        globalDeadLabel.text = statistics.totalDeaths
        globalConfirmedLabel.text = statistics.totalConfirmed
        globalRecoveredLabel.text = statistics.totalRecovered
    }

    func setGhanaStatistics(){
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let item = ghStatistics.data.first else {
            return
        }

        ghanaConfirmedLabel.text = numberFormatter.string(from: NSNumber(value:Int(item.totalConfirmed) ?? 0))
        ghanaCriticalLabel.text = item.newConfirmed
        ghanaDeadLabel.text = item.totalDeaths
        ghanaRecoveredLabel.text = item.totalRecovered

    }
}
