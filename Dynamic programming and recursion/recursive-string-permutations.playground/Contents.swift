func getPermutations(for inputString: String) -> Set<String> {
  
  // generate all permutations of the input string
  
  
  return []
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testEmptyString() {
    let actual = getPermutations(for: "")
    let expected: Set = [""]
    XCTAssertEqual(actual, expected)
  }
  
  func testOneCharacterString() {
    let actual = getPermutations(for: "a")
    let expected: Set = ["a"]
    XCTAssertEqual(actual, expected)
  }
  
  func testTwoCharacterString() {
    let actual = getPermutations(for: "ab")
    let expected: Set = ["ab", "ba"]
    XCTAssertEqual(actual, expected)
  }
  
  func testThreeCharacterString() {
    let actual = getPermutations(for: "abc")
    let expected: Set = ["abc", "acb", "bac", "bca", "cab", "cba"]
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testEmptyString", testEmptyString),
    ("testOneCharacterString", testOneCharacterString),
    ("testTwoCharacterString", testTwoCharacterString),
    ("testThreeCharacterString", testThreeCharacterString)
  ]
}

Tests.defaultTestSuite.run()
