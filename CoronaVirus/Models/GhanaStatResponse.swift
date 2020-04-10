//
//  Country.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 05/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public struct GhanaStatResponse : Codable, Equatable {
    var code: Int
    var data: [GhanaStat]
    
    public static func == (lhs: GhanaStatResponse, rhs: GhanaStatResponse) -> Bool {
        return (lhs.data[0].date == rhs.data[0].date)
    }
}
