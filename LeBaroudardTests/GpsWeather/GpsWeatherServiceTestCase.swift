//
//  GpsWeatherServiceTestCase.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 10/05/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import XCTest
@testable import LeBaroudard

class GpsWeatherServiceTestCase: XCTestCase {
    // if there is an error
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        let loc = "lat=48.9118&lon=2.0083"
        gpsWeatherService.getWeather(loc) {  (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // if there is no data
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            weatherSession: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        let loc = "lat=48.9118&lon=2.0083"
        gpsWeatherService.getWeather(loc){ (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // if there is no response
    func testGetWeatherShouldPostFailedCallbackIncorrectResponse() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrecteData, response: FakeResponseData.responseKO, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
         let loc = "lat=48.9118&lon=2.0083"
        gpsWeatherService.getWeather(loc) { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackError() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrecteData, response: FakeResponseData.responseKO, error: FakeResponseData.error))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
         let loc = "lat=48.9118&lon=2.0083"
        gpsWeatherService.getWeather(loc) { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // if there is incorrect data
    func testGetWeatherShouldPostFailedCallbackIncorrectData() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        let loc = "lat=48.9118&lon=2.0083"
        gpsWeatherService.getWeather(loc) { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
//
    // if sucess data response and no error
        func testGetWeatherShouldPostSuccessCallbackAndCorrectData() {
            // Given
            let gpsWeatherService = WeatherService(
                weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrecteData, response: FakeResponseData.responseOK, error: nil))
            // because change queue
            let expectation = XCTestExpectation(description: "Wait for queue change")
            // When
            gpsWeatherService.getWeather { (success, weather) in         // Then
                //            let description = "légères chutes de neige"
                //            let name = "New York"
                XCTAssertTrue(success)
                XCTAssertNotNil(weather)
    
//                XCTAssertEqual(weather?.listw[0].mainw.tempw, 4.61)
//                XCTAssertEqual(weather?.listw[0].namew , "New York")
//                XCTAssertEqual(weather?.listw[0].weatherw[0].descriptionw , "légères chutes de neige")
//                XCTAssertEqual(weather?.listw[0].weatherw[0].iconw , "13n")
//
//                XCTAssertEqual(weather?.listw[1].mainw.tempw, 5.24)
//                XCTAssertEqual(weather?.listw[1].namew , "Colombes")
//                XCTAssertEqual(weather?.listw[1].weatherw[0].descriptionw , "ciel dégagé")
//                XCTAssertEqual(weather?.listw[1].weatherw[0].iconw , "01d")
                // weatherStruc.list[0].name
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)

        }
}
