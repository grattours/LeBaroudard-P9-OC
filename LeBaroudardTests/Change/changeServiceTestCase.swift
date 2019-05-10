//
//  changeServiceTestCase.swift
//  LeBaroudardTests
//
//  Created by Luc Derosne on 01/05/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import XCTest
@testable import LeBaroudard

class ChangeServiceTestClass: XCTestCase {

// case :   there is an error
    func testGetChangeShouldPostFailedCallbackIfAllInError() {
        // Given
        let changeService = ChangeService (
            changeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
                // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        changeService.getChange { (success, change) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // case : there is no data
    func testGetChangeShouldPostFailedCallbackIfNoData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        changeService.getChange { (success, change) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // case : there is no response
    func testGetChangeShouldPostFailedCallbackIncorrectResponse() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: FakeResponseData.changeCorrecteData, response: FakeResponseData.responseKO, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        changeService.getChange { (success, change) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
 
// case : error NetWork
    func testGetChangeShouldFailedCallbacErrorNetwork() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: FakeResponseData.changeCorrecteData, response: FakeResponseData.responseOK, error: FakeResponseData.error))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        changeService.getChange { (success, change) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
// case :  incorrect data
    func testGetChangeShouldFailedCallbackIncorrectData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        changeService.getChange { (success, change) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
// case :  everything allright
    func testGetChangeShouldSuccessAndEveryBackOK() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: FakeResponseData.changeCorrecteData, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        changeService.getChange { (success, change) in         // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
