//
//  LinnarBillmanDemoUITests.swift
//  LinnarBillmanDemoUITests
//
//  Created by Linnar Billman on 2024-11-18.
//

import XCTest

final class LinnarBillmanDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testNavigateToMovieList() throws {
        let app = XCUIApplication()
        app.launchArguments = ["MockedEnvironment"]
        app.launch()
        UserDefaultsHelper.clearDataFromUserDefaults(for: .movies)
        let button = app.buttons["moviesButton"]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssertTrue(app.staticTexts["The Shawshank Redemption"].exists)
    }
    
    @MainActor
    func testNavigateToMovieDetail() throws {
        let app = XCUIApplication()
        app.launchArguments = ["MockedEnvironment"]
        app.launch()
        UserDefaultsHelper.clearDataFromUserDefaults(for: .movies)
        let button = app.buttons["moviesButton"]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssertTrue(app.staticTexts["The Godfather"].exists)
        app.staticTexts["The Godfather"].tap()
        XCTAssertTrue(app.staticTexts["The Godfather"].exists)
        XCTAssertTrue(app.staticTexts["9.2"].exists)
        XCTAssertTrue(app.buttons["imdbButton"].exists)
    }
    
    @MainActor
    func testNavigateToUserList() throws {
        let app = XCUIApplication()
        app.launchArguments = ["MockedEnvironment"]
        app.launch()
        UserDefaultsHelper.clearDataFromUserDefaults(for: .users)
        let button = app.buttons["usersButton"]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssertTrue(app.staticTexts["John Doe"].exists)
    }
    
    @MainActor
    func testNavigateToUserDetail() throws {
        let app = XCUIApplication()
        app.launchArguments = ["MockedEnvironment"]
        app.launch()
        UserDefaultsHelper.clearDataFromUserDefaults(for: .users)
        let button = app.buttons["usersButton"]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssertTrue(app.staticTexts["Jane Doe"].exists)
        app.staticTexts["Jane Doe"].tap()
        XCTAssertTrue(app.staticTexts["janedoe@example.com"].exists)
        XCTAssertTrue(app.staticTexts["Los Angeles"].exists)
        XCTAssertTrue(app.staticTexts["90001 CA"].exists)
    }


    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
