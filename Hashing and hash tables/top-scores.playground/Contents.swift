func sortScores(_ unsortedScores: [Int], withHighest highestPossibleScore: Int) -> [Int] {
  
  // sort the scores in O(n) time
  
  
  return []
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testNoScores() {
    let actual = sortScores([], withHighest: 100)
    let expected: [Int] = []
    XCTAssertEqual(actual, expected)
  }
  
  func testOneScore() {
    let actual = sortScores([55], withHighest: 100)
    let expected = [55]
    XCTAssertEqual(actual, expected)
  }
  
  func testTwoScores() {
    let actual = sortScores([30, 60], withHighest: 100)
    let expected = [60, 30]
    XCTAssertEqual(actual, expected)
  }
  
  func testManyScores() {
    let actual = sortScores([37, 89, 41, 65, 91, 53], withHighest: 100)
    let expected = [91, 89, 65, 53, 41, 37]
    XCTAssertEqual(actual, expected)
  }
  
  func testRepeatedScores() {
    let actual = sortScores([20, 10, 30, 30, 10, 20], withHighest: 100)
    let expected = [30, 30, 20, 20, 10, 10]
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testNoScores", testNoScores),
    ("testOneScore", testOneScore),
    ("testTwoScores", testTwoScores),
    ("testManyScores", testManyScores),
    ("testRepeatedScores", testRepeatedScores)
  ]
}

Tests.defaultTestSuite.run()
