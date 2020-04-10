//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public struct SummaryStat : Codable, Equatable {
    var global: GlobalStat
    var countries: [CountryStat]
    var date: String

    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }

    public static func == (lhs: SummaryStat, rhs: SummaryStat) -> Bool {
        return (lhs.date == rhs.date)
    }
}
