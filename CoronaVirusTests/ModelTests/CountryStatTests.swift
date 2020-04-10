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

class CountryStatTests: XCTestCase {

    var bundle: Bundle!

    override func setUp() {
        bundle = Bundle(for: CountryStatTests.self)
    }

    func testCountryStatResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "country", withExtension: "json") else {
            XCTFail("Missing file: country.json")
            return
        }

        let json = try Data(contentsOf: url)
        let country = try! JSONDecoder().decode(CountryStat.self, from: json)

        XCTAssertEqual(country.country, "ALA Aland Islands")
        XCTAssertEqual(country.slug, "ala-aland-islands")
    }

}
