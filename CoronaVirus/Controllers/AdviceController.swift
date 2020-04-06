//
//  AdviceController.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import SafariServices

class AdviceController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()
    }

    func openLink(_ link: String) {
        if let url = URL(string: link) {
            let vc1 = SFSafariViewController(url: url)
            self.present(vc1, animated: true)
        }
    }

    @IBAction func needToKnow(_ sender: Any) {
        self.openLink("https://www.who.int/health-topics/coronavirus#tab=tab_1")
    }

    @IBAction func protectYourself(_ sender: Any) {
        self.openLink("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public")
    }

    @IBAction func socialDistancing(_ sender: Any) {
        self.openLink("https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/social-distancing.html")
    }

    @IBAction func selfIsolation(_ sender: Any) {
        self.openLink("https://ghanahealthservice.org/covid19/downloads/covid_19_self_quarantine.pdf")
    }

    @IBAction func personalHygiene(_ sender: Any) {
        self.openLink("https://www.health.gov.au/news/health-alerts/novel-coronavirus-2019-ncov-health-alert/how-to-protect-yourself-and-others-from-coronavirus-covid-19/good-hygiene-for-coronavirus-covid-19")
    }

    @IBAction func faqs(_ sender: Any) {
        self.openLink("https://www.who.int/news-room/q-a-detail/q-a-coronaviruses")
    }

    @IBAction func publication(_ sender: Any) {
        self.openLink("https://www.ghanahealthservice.org/ghs-category.php?cid=5")
    }

    @IBAction func pressRelease(_ sender: Any) {
        self.openLink("https://ghanahealthservice.org/covid19/press-releases.php")
    }

    @IBAction func cancellations(_ sender: Any) {
        self.openLink("https://ghanahealthservice.org/covid19/cancelled.php")
    }

    @IBAction func minInformation(_ sender: Any) {
        self.openLink("http://moi.gov.gh/category/moi-news/covid-19/")
    }

    @IBAction func offers(_ sender: Any) {
        self.openLink("https://technationgh.com/stay-at-home-offers/")
    }

}
