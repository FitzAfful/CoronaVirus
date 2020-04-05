//
//  EmployeeTests.swift
//  MockingProjectTests
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import XCTest
@testable import CoronaVirus
@testable import Alamofire
@testable import Mocker

class SummaryStatTests: XCTestCase {

    var bundle: Bundle!

    override func setUp() {
        bundle = Bundle(for: SummaryStatTests.self)
    }

    func testSummaryStatResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "summary", withExtension: "json") else {
            XCTFail("Missing file: global.json")
            return
        }

        let json = try Data(contentsOf: url)
        let summary = try! JSONDecoder().decode(SummaryStat.self, from: json)

        XCTAssertEqual(summary.date, "2020-04-05T17:06:39Z")
        XCTAssertEqual(summary.global.newConfirmed, 100282)
    }
}
