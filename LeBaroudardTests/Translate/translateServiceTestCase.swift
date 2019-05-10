//
//  translateServiceTestCase.swift
//  LeBaroudardTests
//
//  Created by Luc Derosne on 01/05/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import XCTest
@testable import LeBaroudard

class TranslateServiceTestCase: XCTestCase {
    
//    override func setUp() {
//    }
    
// case :   correct data correct response and no error
    func testGetTranslateShouldSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrecteData, response: FakeResponseData.responseOK, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(InputText: text) { (success, translatedText) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            
            let translation = "Hello"
            XCTAssertEqual(translation, translatedText )
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // case :   incorrect response
    func testGetTranslationShouldFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrecteData, response: FakeResponseData.responseKO, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(InputText: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // case :   incorrect data
    func testGetTranslationShouldFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(InputText: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // case :   no data
    func testGetTraductionShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(InputText: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // case :   an error
    func testGetTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(InputText: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
