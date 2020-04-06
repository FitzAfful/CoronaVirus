//
//  EmergencyCell.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import SafariServices

class EmergencyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var bgColorView: UIView!

    var controller: ContactController?

    var item: EmergencyContact? {
        didSet {
            guard let emergencyContact = item else { return }
            self.titleLabel.text = "  " + emergencyContact.title
            self.descriptionLabel.text = emergencyContact.details
            self.descriptionLabel.addInterlineSpacing(spacingValue: 3)
            if emergencyContact.isWebsite {
                self.callButton.setTitle(" Visit GHS Covid-19 website", for: UIControl.State())
                self.callButton.setImage(nil, for: UIControl.State())
            }else {
                self.callButton.setTitle("   Call \(emergencyContact.contactNumber)", for: UIControl.State())
            }
            self.bgColorView.backgroundColor = UIColor(hex: emergencyContact.color)
            self.titleLabel.backgroundColor = UIColor(hex: emergencyContact.color)
            self.callButton.addTarget(self, action: #selector(callNumber), for: UIControl.Event.touchUpInside)
        }
    }

    @objc func callNumber(_ sender: Any){
        if item!.isWebsite {
            let link = item!.contactNumber
            if let url = URL(string: link) {
                let vc1 = SFSafariViewController(url: url)
                controller!.present(vc1, animated: true)
            }
            return
        }
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
