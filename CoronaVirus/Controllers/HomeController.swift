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
    var statistics: SummaryStat!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()
        if let dictionary = UserDefaults.standard.dictionary(forKey: "stats") {
            if let object = try? DictionaryDecoder().decode(SummaryStat.self, from: dictionary){
                self.statistics = object
                self.setStatistics()
            }
        }
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
        APIManager().getSummaryStats { (result) in
            switch result.result {
            case.success(let response):
                UserDefaults.standard.set(response.dictionary, forKey: "stats")
                self.statistics = response
                self.loader.isHidden = true
                self.setStatistics()
            case .failure:
            self.loader.isHidden = true
                self.showAlert(withTitle: "Error", message: "Could not retrieve latest statistics. Please try again later.")
            }
        }
    }

    func setStatistics(){
        let ghanaStats = statistics.countries.filter { (country) -> Bool in
            return country.countryCode == "GH"
        }.first!

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        ghanaConfirmedLabel.text = numberFormatter.string(from: NSNumber(value:ghanaStats.totalConfirmed))
        ghanaCriticalLabel.text = "\(ghanaStats.newConfirmed)"
        ghanaDeadLabel.text = "\(ghanaStats.totalDeaths)"
        ghanaRecoveredLabel.text = numberFormatter.string(from: NSNumber(value:ghanaStats.totalRecovered))

        globalDeadLabel.text = numberFormatter.string(from: NSNumber(value:statistics.global.totalDeaths))
        globalConfirmedLabel.text = numberFormatter.string(from: NSNumber(value:statistics.global.totalConfirmed))
        globalRecoveredLabel.text = numberFormatter.string(from: NSNumber(value:statistics.global.totalRecovered))
    }
}
