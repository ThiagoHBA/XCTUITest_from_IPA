//
//  UITestFromIPAUITests.swift
//  UITestFromIPAUITests
//
//  Created by Thiago Henrique on 18/05/23.
//

import XCTest

final class UITestFromIPAUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication(bundleIdentifier: "com.apple.reminders")
        app.launch()
//        let screenshot = app.screenshot()
//        let snapshot = try! app.snapshot()
    }
    
    override func tearDown() { app.terminate() }
    
    func test_verify_minimumSize_should_be_greather_than_18() {
        assertForAllElements { element in
            XCTAssertGreaterThanOrEqual(element.frame.size.height, 18.0)
            XCTAssertGreaterThanOrEqual(element.frame.size.width, 18.0)
        }
    }
    
    func test_verify_accessibility_label_should_been_short() {
        assertForAllElements { element in
            XCTAssertLessThanOrEqual(element.label.count, 40)
        }
    }
    
    func test_verify_target_size_should_be_greater_than_44() {
        assertForAllElements { currentElement in
            XCTAssertGreaterThanOrEqual(currentElement.frame.size.height, 44)
            XCTAssertGreaterThanOrEqual(currentElement.frame.size.width, 44)
        }
    }
}

extension UITestFromIPAUITests {
    
    func assertForAllElements(_ assertion: (_ currentElement: XCUIElement) -> Void) {
        let elements = getElements()
        for element in elements { assertion(element) }
    }
    
    func getElements() -> [XCUIElement] {
        return app
            .descendants(matching: .any)
            .matching(NSPredicate(value: true))
            .allElementsBoundByIndex
    }
}
