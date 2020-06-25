func isValid(code: String) -> Bool {
  // we'll keep a stack of openers
  // as we iterate through the string
  // when we find an opener we add it to the stack
  // when we find a closer
  // if it matches the top of the stack opener
  // we pop the opener and continue
  // if it doesn't, there could have been too reasons
  // we didn't have anything in the stack
  // or it didn't match
  // in either case we return false
  // if we go through the whole string and we good, then we good
  var stack = [Character]()
  let openers = "({["
  let closers = ")}]"
  
  let closerFor: [Character: Character] = ["(": ")", "{": "}", "[": "]"]
  
  for char in code {
    if openers.contains(char) {
      stack.append(char)
      continue
    }
    
    if closers.contains(char) {
      guard let lastOpener = stack.popLast(), closerFor[lastOpener] == char else {
        return false
      }
    }
  }
  
  
  return stack.isEmpty
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testValidShortCode() {
    let result = isValid(code: "()")
    XCTAssertTrue(result)
  }
  
  func testValidLongerCode() {
    let result = isValid(code: "([]{[]})[]{{}()}")
    XCTAssertTrue(result)
  }
  
  func testInterleavedOpenersAndClosers() {
    let result = isValid(code: "([)]")
    XCTAssertFalse(result)
  }
  
  func testMismatchedOpenerAndCloser() {
    let result = isValid(code: "([][]}")
    XCTAssertFalse(result)
  }
  
  func testMissingCloser() {
    let result = isValid(code: "[[]()")
    XCTAssertFalse(result)
  }
  
  func testExtraCloser() {
    let result = isValid(code: "[[]]())")
    XCTAssertFalse(result)
  }
  
  func testEmptyString() {
    let result = isValid(code: "")
    XCTAssertTrue(result)
  }
  
  static let allTests = [
    ("testValidShortCode", testValidShortCode),
    ("testValidLongerCode", testValidLongerCode),
    ("testInterleavedOpenersAndClosers", testInterleavedOpenersAndClosers),
    ("testMismatchedOpenerAndCloser", testMismatchedOpenerAndCloser),
    ("testMissingCloser", testMissingCloser),
    ("testExtraCloser", testExtraCloser),
    ("testEmptyString", testEmptyString)
  ]
}

Tests.defaultTestSuite.run()
