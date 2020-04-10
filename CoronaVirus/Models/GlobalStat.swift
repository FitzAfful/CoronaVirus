//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public struct GlobalStat : Codable, Equatable {
    var newConfirmed: Int
    var totalConfirmed: Int
    var newDeaths: Int
    var totalDeaths: Int
    var newRecovered: Int
    var totalRecovered: Int

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }

    public static func == (lhs: GlobalStat, rhs: GlobalStat) -> Bool {
        return (lhs.newConfirmed == rhs.newConfirmed)
    }
}
