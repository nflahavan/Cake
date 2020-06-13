func hasPalindromePermutation(in theString: String) -> Bool {
  
  var charOccurancesDict = [Character: Int]()
  
  for char in theString {
  
    if charOccurancesDict[char] != nil {
      
      charOccurancesDict[char]! += 1
    } else {
      
      charOccurancesDict[char] = 1
    }
  }
  
  var numOddOccurances = 0
  
  for char in theString {
  
    if !charOccurancesDict[char]!.isMultiple(of: 2) {
      
      numOddOccurances += 1
      
      if numOddOccurances > 1 {
        
        return false
      }
    }
  }
  
  return true
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testPermutationWithOddNumberOfChars() {
    let result = hasPalindromePermutation(in: "aabcbcd")
    XCTAssertTrue(result)
  }
  
  func testPermutationWithEvenNumberOfChars() {
    let result = hasPalindromePermutation(in: "aabccbdd")
    XCTAssertTrue(result)
  }
  
  func testNoPermutationWithOddNumberOfChars() {
    let result = hasPalindromePermutation(in: "aabcd")
    XCTAssertFalse(result)
  }
  
  func testNoPermutationWithEvenNumberOfChars() {
    let result = hasPalindromePermutation(in: "aabbcd")
    XCTAssertFalse(result)
  }
  
  func testEmptyString() {
    let result = hasPalindromePermutation(in: "")
    XCTAssertTrue(result)
  }
  
  func testOneCharacterString() {
    let result = hasPalindromePermutation(in: "a")
    XCTAssertTrue(result)
  }
  
  static let allTests = [
    ("testPermutationWithOddNumberOfChars", testPermutationWithOddNumberOfChars),
    ("testPermutationWithEvenNumberOfChars", testPermutationWithEvenNumberOfChars),
    ("testNoPermutationWithOddNumberOfChars", testNoPermutationWithOddNumberOfChars),
    ("testNoPermutationWithEvenNumberOfChars", testNoPermutationWithEvenNumberOfChars),
    ("testEmptyString", testEmptyString),
    ("testOneCharacterString", testOneCharacterString)
  ]
}

Tests.defaultTestSuite.run()
