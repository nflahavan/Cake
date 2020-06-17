func findRotationPoint(in words: [String]) -> Int {
  var floor = -1
  var ceiling = words.count
  var currLow = 0
  
  while floor + 1 < ceiling {
    let dist = ceiling - floor
    let halfDist = dist / 2
    let guessIndex = floor + halfDist
    let guessValue = words[guessIndex]
    let target = words[currLow]
    
    if guessValue >= target {
      floor = guessIndex
    } else {
      currLow = guessIndex
      ceiling = guessIndex
    }
  }
  
  return currLow
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testUnrotatedArray() {
    let actual = findRotationPoint(in: ["a", "b", "c"])
    let expected = 0
    XCTAssertEqual(actual, expected)
  }
  
  func testSmallArray() {
    let actual = findRotationPoint(in: ["cape", "cake"])
    let expected = 1
    XCTAssertEqual(actual, expected)
  }
  
  func testMediumArray() {
    let actual = findRotationPoint(in: ["grape", "orange",
                                        "plum", "radish", "apple"])
    let expected = 4
    XCTAssertEqual(actual, expected)
  }
  
  func testLargeArray() {
    let actual = findRotationPoint(in: ["ptolemaic", "retrograde", "supplant",
                                        "undulate", "xenoepist", "asymptote",
                                        "babka", "banoffee", "engender",
                                        "karpatka", "othellolagkage"])
    let expected = 5
    XCTAssertEqual(actual, expected)
  }
  
  // are we missing any edge cases?
  
  static let allTests = [
    ("testUnrotatedArray", testUnrotatedArray),
    ("testSmallArray", testSmallArray),
    ("testMediumArray", testMediumArray),
    ("testLargeArray", testLargeArray)
  ]
}

Tests.defaultTestSuite.run()
