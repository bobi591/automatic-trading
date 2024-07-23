//
//  Trading212PositionServiceTests.swift
//  AutomaticOrderExecutionTests
//
//  Created by Boris Georgiev on 21.07.24.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import AutomaticOrderExecution

final class Trading212PositionServiceTests: XCTestCase {
    override func setUpWithError() throws {
        try KeychainUtils.store("fakeApiKey", key: KeychainUtils.Keys.apiKeyTrading212)
        try super.setUpWithError()
    }
    
    func testAllPositions() async throws {
        let expectedResult: [Trading212Position] = [Trading212Position(averagePrice: 100, currentPrice: 100, initialFillDate: "2024-07-19T17:45:01.000+03:00", quantity: 10, ppl: 100.50, fxPpl: -10.5, ticker: "AAPL")]
        
        let positionProvider: Trading212PositionService = Trading212PositionService()
        
        stub(condition: isAbsoluteURLString(positionProvider.positionsUrl)) {
            _ in
            let stubData = try! JSONEncoder().encode(expectedResult)
            return HTTPStubsResponse(data: stubData, statusCode: 200, headers: nil)
        }
        
        let result: [Trading212Position] = try! await positionProvider.allPositions();
        
        XCTAssertNotNil(result, "Result not nil.")
        XCTAssertTrue(result.count == 1, "Result size equal to 1.")
        XCTAssertEqual(result.first, expectedResult.first)
        XCTAssertNotNil(result.first?.getFillDate(), "Assert date conversion is correct.")
    }
    
    override func tearDownWithError() throws {
        HTTPStubs.removeAllStubs()
        try KeychainUtils.removeAll()
        try super.tearDownWithError()
    }
}
