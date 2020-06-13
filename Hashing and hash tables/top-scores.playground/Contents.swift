func sortScores(_ unsortedScores: [Int], withHighest highestPossibleScore: Int) -> [Int] {
  
  var scoresCounts = Array(repeating: 0, count: highestPossibleScore + 1)
  
  for score in unsortedScores {
  
    scoresCounts[score] += 1
  }
  
  print(scoresCounts.compactMap({ $0 != 0 ? $0 : nil}))
  var sortedScores = Array(repeating: 0, count: unsortedScores.count)
  var sortedScoresIndex = sortedScores.startIndex
  
  for score in scoresCounts.indices.reversed() {

    let scoreCount = scoresCounts[score]
    
    guard scoreCount > 0 else { continue }
    
    for _ in 0..<scoreCount {
      
      sortedScores[sortedScoresIndex] = score
      sortedScoresIndex = sortedScores.index(after: sortedScoresIndex)
    }
  }
  
  return sortedScores
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
  
  func testHighLowScores() {
    let actual = sortScores([0, 0, 100, 100], withHighest: 100)
    let expected = [100, 100, 0, 0]
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
