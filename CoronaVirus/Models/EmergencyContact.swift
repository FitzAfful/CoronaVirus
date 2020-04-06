//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public class EmergencyContact : Codable {
    var title: String
    var details: String
    var contactNumber: String
    var color: String
    var isWebsite: Bool

    init( title: String, details: String, contactNumber: String, color: String, isWebsite: Bool) {
        self.title = title
        self.details = details
        self.contactNumber = contactNumber
        self.color = color
        self.isWebsite = isWebsite
    }
}
