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

        emergencyItems = [EmergencyContact(title: "General Information", details: "Call this number if you are seeking information on coronavirus (Covid-19) - non emergency cases.", contactNumber: "311", color: "#154360", isWebsite: false), EmergencyContact(title: "Emergency", details: "Please only use this phone number for emergency calls regarding vulnerable people in relation to coronavirus", contactNumber: "112", color: "#7D6608", isWebsite: false), EmergencyContact(title: "Hotline 1", details: "Call this number if you are seeking information on clarification on imposition of restrictions.", contactNumber: "0307011419", color: "#641E16", isWebsite: false), EmergencyContact(title: "Ghana Health Service Website", details: "For situational updates on Covid-19 from the Ghana Health Service / Ministry of Information, visit this website.", contactNumber: "https://ghanahealthservice.org/covid19/", color: "#145A32", isWebsite: true)]
        self.tableView.reloadData()
    }
    
}

extension ContactController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emergencyItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTag, for: indexPath) as! EmergencyCell
        cell.controller = self
        cell.item = self.emergencyItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
