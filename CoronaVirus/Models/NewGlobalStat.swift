//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public struct NewGlobalStat : Codable, Equatable {
    var totalConfirmed: String
    var totalDeaths: String
    var totalRecovered: String

    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "currently_infected"
        case totalDeaths = "death_cases"
        case totalRecovered = "recovery_cases"
    }

    public static func == (lhs: NewGlobalStat, rhs: NewGlobalStat) -> Bool {
        return (lhs.totalConfirmed == rhs.totalConfirmed)
    }
}


public struct NewSummaryStatResponse : Codable, Equatable {
    var data: NewGlobalStat
    var status: String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
    }

}
