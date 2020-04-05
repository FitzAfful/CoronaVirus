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

class CountryStatTests: XCTestCase {

    var bundle: Bundle!

    override func setUp() {
        bundle = Bundle(for: CountryStatTests.self)
    }

    func testSingleCountryResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "country", withExtension: "json") else {
            XCTFail("Missing file: country.json")
            return
        }

        let json = try Data(contentsOf: url)
        let country = try! JSONDecoder().decode(CountryStat.self, from: json)

        XCTAssertEqual(country.country, "ALA Aland Islands")
        XCTAssertEqual(country.slug, "ala-aland-islands")
    }

    func testGlobalResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "global", withExtension: "json") else {
            XCTFail("Missing file: global.json")
            return
        }

        let json = try Data(contentsOf: url)
        let global = try! JSONDecoder().decode(GlobalStat.self, from: json)

        XCTAssertEqual(global.newConfirmed, 100282)
        XCTAssertEqual(global.totalConfirmed, 1162857)
    }

    func testSummaryResponseJSONMapping() throws {
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
