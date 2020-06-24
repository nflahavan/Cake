func getClosingParen(for sentence: String, openingParenIndex: String.Index) -> String.Index? {
  
  // we'll return nil if we can never find closing paren
  // we'll use a stack
  // while we have more characters
  // when we encounter a opening paren we push
  // when we encounter a closing paren we pop
  // if we try and pop and nothing is in our stack, it's our closing paren
  var currIndex = sentence.index(after: openingParenIndex)
  var stackCount = 0
  
  while currIndex != sentence.endIndex {
    let curr = sentence[currIndex]
    if curr == ")" {
      guard stackCount != 0 else { return currIndex }
      stackCount -= 1
    } else if curr == "(" {
      stackCount += 1
    }
    currIndex = sentence.index(after: currIndex)
  }
  
  return nil
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testAllOpenersThenClosers() {
    let word = "((((()))))"
    let index = word.index(word.startIndex, offsetBy: 2)
    let actual = getClosingParen(for: word, openingParenIndex: index)
    let expected = word.index(word.startIndex, offsetBy: 7)
    XCTAssertEqual(actual, expected)
  }
  
  func testMixedOpenersAndClosers() {
    let word = "()()((()()))"
    let index = word.index(word.startIndex, offsetBy: 5)
    let actual = getClosingParen(for: word, openingParenIndex: index)
    let expected = word.index(word.startIndex, offsetBy: 10)
    XCTAssertEqual(actual, expected)
  }
  
  func testNoMatchingCloser() {
    let word = "()(()"
    let index = word.index(word.startIndex, offsetBy: 2)
    let result = getClosingParen(for: word, openingParenIndex: index)
    XCTAssertNil(result)
  }
  
  static let allTests = [
    ("testAllOpenersThenClosers", testAllOpenersThenClosers),
    ("testMixedOpenersAndClosers", testMixedOpenersAndClosers),
    ("testNoMatchingCloser", testNoMatchingCloser)
  ]
}

Tests.defaultTestSuite.run()
