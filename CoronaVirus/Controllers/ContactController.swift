//
//  ContactController.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class ContactController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var emergencyItems: [EmergencyContact] = []
    var cellTag = "EmergencyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDarkMode()
        self.setupTableView()
    }

    func setupTableView(){
        self.tableView.register(UINib(nibName: cellTag, bundle: nil), forCellReuseIdentifier: cellTag)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()

        emergencyItems = [EmergencyContact(title: "Contact General Practitioner", details: "Call this number if you are seeking information on coronavirus (Covid-19). The line operates 24 hours a day, 7 days a week", contactNumber: "100", color: "#154360"), EmergencyContact(title: "Contact General Practitioner", details: "Call this number if you are seeking information on coronavirus (Covid-19). The line operates 24 hours a day, 7 days a week", contactNumber: "100", color: "#7D6608"), EmergencyContact(title: "Contact General Practitioner", details: "Call this number if you are seeking information on coronavirus (Covid-19). The line operates 24 hours a day, 7 days a week", contactNumber: "100", color: "#641E16"), EmergencyContact(title: "Contact General Practitioner", details: "Call this number if you are seeking information on coronavirus (Covid-19). The line operates 24 hours a day, 7 days a week", contactNumber: "100", color: "#145A32")]
        self.tableView.reloadData()
    }
    
}

extension ContactController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emergencyItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTag, for: indexPath) as! EmergencyCell
        cell.item = self.emergencyItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
