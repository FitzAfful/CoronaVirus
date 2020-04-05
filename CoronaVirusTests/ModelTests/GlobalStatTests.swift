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

class GlobalStatTests: XCTestCase {

    var bundle: Bundle!

    override func setUp() {
        bundle = Bundle(for: GlobalStatTests.self)
    }

    func testGlobalStatResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "global", withExtension: "json") else {
            XCTFail("Missing file: global.json")
            return
        }

        let json = try Data(contentsOf: url)
        let global = try! JSONDecoder().decode(GlobalStat.self, from: json)

        XCTAssertEqual(global.newConfirmed, 100282)
        XCTAssertEqual(global.totalConfirmed, 1162857)
    }

}
