//
//  SymptomsController.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import SafariServices

class SymptomsController: UITableViewController {

    @IBOutlet weak var symptomLabel: UILabel!

    let symptoms = "People with coronavirus may experience: \n\n•  Fever\n\n•  Flu-like symptons such as coughing, sore throat and fatigue\n\n•  Shortness of breath\n\n•  Headache\n\nIf you are concerned you may have COVID-19, use the symptom checker below\n\n"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()
        self.symptomLabel.text = symptoms
    }

    @IBAction func checkSymptoms(_ sender: Any) {
        let link = "https://www.apple.com/covid19/"
        if let url = URL(string: link) {
            let vc1 = SFSafariViewController(url: url)
            self.present(vc1, animated: true)
        }
    }

    @IBAction func learnMore(_ sender: Any) {
        let link = "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses"
        if let url = URL(string: link) {
            let vc1 = SFSafariViewController(url: url)
            self.present(vc1, animated: true)
        }
    }

}
