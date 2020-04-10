//
//  EmployeeTests.swift
//  MockingProjectTests
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import XCTest
@testable import Coronavirus_Ghana
@testable import Alamofire
@testable import Mocker

class GhanaStatTests: XCTestCase {

    var bundle: Bundle!

    override func setUp() {
        bundle = Bundle(for: GhanaStatTests.self)
    }

    func testSummaryStatResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "ghanaStat", withExtension: "json") else {
            XCTFail("Missing file: ghanaStat.json")
            return
        }

        let json = try Data(contentsOf: url)
        let ghStat = try! JSONDecoder().decode(GhanaStat.self, from: json)

        XCTAssertEqual(ghStat.totalConfirmed, "1")
    }
}
