//
//  MockingProjectTests.swift
//  MockingProjectTests
//
//  Created by Fitzgerald Afful on 02/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import XCTest
@testable import Coronavirus_Ghana
@testable import Alamofire
@testable import Mocker

class APIManagerTests: XCTestCase {

    private var manager: APIManager!

    override func setUp() {
        let sessionManager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
                return configuration
            }()
            return Session(configuration: configuration)
        }()
        manager = APIManager(manager: sessionManager)
    }


    func test_getEmployees() {

        let apiEndpoint = URL(string: APIRouter.getSummaryStats.path)!
        let requestExpectation = expectation(description: "Request should finish with Employees")
        let responseFile = "summary"
        guard let mockedData = dataFromTestBundleFile(fileName: responseFile, withExtension: "json") else {
            XCTFail("Error from JSON DeSerialization.jsonObject")
            return
        }
        guard let mockResponse = try? JSONDecoder().decode(SummaryStat.self, from: mockedData) else {
            XCTFail("Error from JSON DeSerialization.jsonObject")
            return
        }

        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()

        manager.getSummaryStats { (result) in
            XCTAssertEqual(result.result.success!, mockResponse)
            XCTAssertNil(result.error)
            requestExpectation.fulfill()
        }

        wait(for: [requestExpectation], timeout: 10.0)
    }

    func test_getGhanaStats() {

        let apiEndpoint = URL(string: APIRouter.getGhanaStats.path)!
        let requestExpectation = expectation(description: "Request should finish with Employees")
        let responseFile = "ghanaResponse"
        guard let mockedData = dataFromTestBundleFile(fileName: responseFile, withExtension: "json") else {
            XCTFail("Error from JSON DeSerialization.jsonObject")
            return
        }
        guard let mockResponse = try? JSONDecoder().decode(GhanaStatResponse.self, from: mockedData) else {
            XCTFail("Error from JSON DeSerialization.jsonObject")
            return
        }

        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()

        manager.getGhanaStats { (result) in
            XCTAssertEqual(result.result.success!, mockResponse)
            XCTAssertNil(result.error)
            requestExpectation.fulfill()
        }

        wait(for: [requestExpectation], timeout: 10.0)
    }



    func verifyAndConvertToDictionary(data: Data?) -> [String: Any]? {

        XCTAssertNotNil(data)
        guard let data = data else { return nil }

        do {
            let dataObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dataDict = dataObject as? [String: Any] else {
                XCTFail("data object is not of type [String: Any]. dataObject=\(dataObject )")
                return nil
            }

            return dataDict
        } catch {
            XCTFail("Error from JSONSerialization.jsonObject; error=\(error)")
            return nil
        }
    }

    func dataFromTestBundleFile(fileName: String, withExtension fileExtension: String) -> Data? {

        let testBundle = Bundle(for: APIManagerTests.self)
        let resourceUrl = testBundle.url(forResource: fileName, withExtension: fileExtension)!
        do {
            let data = try Data(contentsOf: resourceUrl)
            return data
        } catch {
            XCTFail("Error reading data from resource file \(fileName).\(fileExtension)")
            return nil
        }
    }

}
