/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest

class SwiftCalcUITests: XCTestCase {
	
	override func setUpWithError() throws {
		continueAfterFailure = false
	}
	
	func testPressMemoryPlusAtAppStartShowZeroInDisplay() throws {
		let app = XCUIApplication()
		app.launch()
		app.buttons["M+"].tap()
		
		XCTAssert(app.staticTexts["display"].label == "0")
	}
	
	func testAddingTwoDigits() {
		let app = XCUIApplication()
		app.launch()
		
		app.buttons["3"].tap()
		app.buttons["+"].tap()
		app.buttons["5"].tap()
		app.buttons["="].tap()
		
		XCTAssert(app.staticTexts["display"].label == "8.0")
	}
	
	// Does not work w/ Catalyst (macOS)
	#if !os(macOS)
	func testSwipeToClearMemory() {
		let app = XCUIApplication()
		app.launch()
		
		app.buttons["3"].tap()
		app.buttons["5"].tap()
		app.buttons["M+"].tap()
		
		let memoryDisplay  = app.staticTexts["memoryDisplay"]
		XCTAssert(memoryDisplay.exists)
		
		memoryDisplay.swipeLeft()
		XCTAssertFalse(memoryDisplay.exists)
	}
	#endif
	
	func testLaunchPerformance() throws {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}
}
