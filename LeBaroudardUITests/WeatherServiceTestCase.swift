//
//  WeatherServiceTestCase.swift
//  LeBaroudardTests
//
//  Created by Luc Derosne on 26/02/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import XCTest
@testable import LeBaroudard

class WeatherServiceTestCase: XCTestCase {
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        weatherService.getWeather { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        weatherService.getWeather { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrecteData, response: FakeResponseData.responseKO, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        weatherService.getWeather { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        weatherService.getWeather { (success, weather) in         // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrecteData, response: FakeResponseData.responseOK, error: nil))
        // because change queue
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // When
        weatherService.getWeather { (success, weather) in         // Then
            //            let description = "légères chutes de neige"
            //            let name = "New York"
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            XCTAssertEqual(weather?.list[0].main.temp, 5.24)
            XCTAssertEqual(weather?.list[0].name , "Colombes")
            XCTAssertEqual(weather?.list[0].weather[0].description , "ciel dégagé")
            XCTAssertEqual(weather?.list[0].weather[0].icon , "01d")
            
            XCTAssertEqual(weather?.list[1].main.temp, 4.61)
            XCTAssertEqual(weather?.list[1].name , "New York")
            XCTAssertEqual(weather?.list[1].weather[0].description , "ciel dégagé")
            XCTAssertEqual(weather?.list[1].weather[0].icon , "01d")
            // weatherStruc.list[0].name
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    //    self.botTown.text = weatherStruc.list[1].name
    //    self.botTemperature.text = String(weatherStruc.list[1].main.temp) + "°C"
    //    self.botCondition.text = weatherStruc.list[1].weather[0].description
    //    self.botImage.image = UIImage(named: weatherStruc.list[1].weather[0].icon)
    
    //    self.topTown.text = weatherStruc.list[0].name
    //    self.topTemperature.text = String(weatherStruc.list[0].main.temp) + "°C"
    //    self.topCondition.text = weatherStruc.list[0].weather[0].description
    //    self.topImage.image = UIImage(named: weatherStruc.list[0].weather[0].icon)
    //    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
    //
    //    }
    //
    //    func testGetWeatherShouldPostFailedCallbackIfNoData() {
    //    }
    //
    //    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
    //    }
    //
    //    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
    //    }
}

