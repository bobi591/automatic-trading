//
//  RestUtilsTests.swift
//  AutomaticOrderExecutionTests
//
//  Created by Boris Georgiev on 21.07.24.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import AutomaticOrderExecution

final class RestUtilsTests: XCTestCase {
    
    private var API_URL = "https://mylovelyapi.com/api/test"
    
    struct MockResponse: Codable, Equatable {
        let testFieldString: String
        let testFieldDecimal: Decimal
    }
    
    override func setUp() {
        super.setUp()
    }
    
    func testHttpActionGet() async throws {
        let expectedResult = MockResponse(testFieldString: "test", testFieldDecimal: 1)
        stub(condition: isAbsoluteURLString(API_URL)) {
            _ in
            let stubData = try! JSONEncoder().encode(expectedResult)
            return HTTPStubsResponse(data: stubData, statusCode: 200, headers: nil)
            
        }
        let response: MockResponse = try await RestUtils.get(urlString: API_URL)
        XCTAssertNotNil(response, "Assert GET action response is not nil.")
        XCTAssertEqual(response, expectedResult)
    }
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }
}
