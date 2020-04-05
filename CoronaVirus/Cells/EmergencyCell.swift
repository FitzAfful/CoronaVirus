//
//  EmergencyCell.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class EmergencyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var bgColorView: UIView!

    var item: EmergencyContact? {
        didSet {
            guard let emergencyContact = item else { return }
            self.titleLabel.text = "  " + emergencyContact.title
            self.descriptionLabel.text = emergencyContact.details
            self.descriptionLabel.addInterlineSpacing(spacingValue: 3)
            self.callButton.setTitle("Call \(emergencyContact.contactNumber)", for: UIControl.State())
            self.bgColorView.backgroundColor = UIColor(hex: emergencyContact.color)
            self.titleLabel.backgroundColor = UIColor(hex: emergencyContact.color)
            self.callButton.addTarget(self, action: #selector(callNumber), for: UIControl.Event.touchUpInside)
        }
    }

    @objc func callNumber(_ sender: Any){
        if let url = URL(string: "tel://\(item!.contactNumber)"),
        UIApplication.shared.canOpenURL(url) {
           if #available(iOS 10, *) {
             UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}
