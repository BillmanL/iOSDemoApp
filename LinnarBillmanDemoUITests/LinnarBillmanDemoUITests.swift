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
        app.launch()
        let button = app.buttons["moviesButton"]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssert(app.staticTexts["Movies"].exists || app.staticTexts["Filmer"].exists)
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
