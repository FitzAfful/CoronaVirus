//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public struct GhanaStat : Codable, Equatable {
    var newConfirmed: String
    var totalConfirmed: String
    var totalDeaths: String
    var totalRecovered: String
    var date: String

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "total_new_cases"
        case totalConfirmed = "total_confirmed_cases"
        case totalDeaths = "total_deaths"
        case totalRecovered = "total_recovered"
        case date = "date"
    }

    public static func == (lhs: GhanaStat, rhs: GhanaStat) -> Bool {
        return (lhs.date == rhs.date)
    }
}
