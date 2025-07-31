//
//  Swift_UIKit_ChatAppUITests.swift
//  Swift_UIKit_ChatAppUITests
//
//  Created by Al-Tameemi Hayder on 16.7.2023.
//

import XCTest

class Swift_UIKit_ChatAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let homeButton = app/*@START_MENU_TOKEN@*/.staticTexts["Move to chats"]/*[[".buttons[\"Move to chats\"].staticTexts[\"Move to chats\"]",".staticTexts[\"Move to chats\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(homeButton.exists, "Home button not found")
        homeButton.tap()
        
        let cellQuery = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(cellQuery.exists, "Chats cell not found")
        cellQuery.tap()
        
//        cellQuery.children(matching: .cell).element(boundBy: 1000).staticTexts["message number 1000"].swipeDown()
        
        for i in 0...1010 {
            if i % 60 == 0 {
                let chatRoomCell = app.tables.cells.element(boundBy: i)
                XCTAssertTrue(chatRoomCell.exists, "Chat room cell not found \(i)")
                chatRoomCell.tap()
            }
        }
//        let chatRoomCell = app.tables.cells.element(boundBy: 0)
//        XCTAssertTrue(chatRoomCell.exists, "Chat room cell not found")
//        chatRoomCell.tap()
        
        print("everything is working")
        
        
        
//        let tableView = app.descendants(matching: .table).firstMatch
//
//        guard let lastCell = tableView.cells.allElementsBoundByIndex.last else { return }
//
//        let MAX_SCROLLS = 10
//        var count = 0
//        while lastCell.isHittable == false && count < MAX_SCROLLS {
//            apps.swipeUp()
//            count += 1
//        }
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
