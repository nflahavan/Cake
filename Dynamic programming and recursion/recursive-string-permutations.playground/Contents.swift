import Foundation

func getPermutations(for inputString: String) -> Set<String> {
  guard inputString.count > 1 else {
    return Set<String>(arrayLiteral: inputString)
  }
  
  var perms = Set<String>()
  
  for i in 0..<inputString.count {
    var str = inputString
    
    let first = String(str[str.startIndex])
    let ithIndex = str.index(str.startIndex, offsetBy: i)
    let ith = String(str[ithIndex])
    
    str.replaceSubrange(ithIndex...ithIndex, with: first)
    str.replaceSubrange(str.startIndex...str.startIndex, with: ith)
    
    let substr = str[str.index(after: str.startIndex)..<str.endIndex]
    let subPerms = getPermutations(for: String(substr))
    
    for subPerm in subPerms {
      var subPermMutable = subPerm
      subPermMutable.insert(contentsOf: ith, at: subPermMutable.startIndex)
      perms.insert(subPermMutable)
    }
  }
  
  return perms
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
