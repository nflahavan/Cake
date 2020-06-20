import Foundation

func findDuplicate(in intArray: [Int]) -> Int {
  
  // we know a loop exists somewhere
  // we know it doesn't include the last index
  // we must do n jumps to ensure we're into the loop
  var position = intArray.count
  for _ in 0..<intArray.count {
    let index = position - 1
    position = intArray[index]
  }
  
  // we must find the size of the loop
  // it could start at one
  var sizeOfLoop = 1
  
  // we make the first jump
  var positionInLoop = intArray[position - 1]
  
  // if the loop is size zero, we'll never enter
  // if the jump didn't get us back to the start, we know the loop is at least
  // larger than we thought by one
  while positionInLoop != position {
    sizeOfLoop += 1
    positionInLoop = intArray[positionInLoop - 1]
  }
  
  // we use the snake method
  // let head of snake get sizeOfLoop jumps away
  // then move head and tail together
  // when head equals tail, we know that position has 2 pointers to it
  // that position is for sure a repeat number in our array
  var headPosition = intArray.count
  var tailPosition = intArray.count
  
  for _ in 0..<sizeOfLoop {
    let index = headPosition - 1
    headPosition = intArray[index]
  }
  
  while headPosition != tailPosition {
    let indexHead = headPosition - 1
    headPosition = intArray[indexHead]
    
    let indexTail = tailPosition - 1
    tailPosition = intArray[indexTail]
  }
  
  return headPosition
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testJustTheRepeatedNumber() {
    let numbers = [1, 1]
    let actual = findDuplicate(in: numbers)
    let expected = 1
    XCTAssertEqual(actual, expected)
  }
  
  func testShortArray() {
    let numbers = [1, 2, 3, 2]
    let actual = findDuplicate(in: numbers)
    let expected = 2
    XCTAssertEqual(actual, expected)
  }
  
  func testMediumArray() {
    let numbers = [1, 2, 5, 5, 5, 5]
    let actual = findDuplicate(in: numbers)
    let expected = 5
    XCTAssertEqual(actual, expected)
  }
  
  func testLongArray() {
    let numbers = [4, 1, 4, 8, 3, 2, 7, 6, 5]
    let actual = findDuplicate(in: numbers)
    let expected = 4
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testJustTheRepeatedNumber", testJustTheRepeatedNumber),
    ("testShortArray", testShortArray),
    ("testMediumArray", testMediumArray),
    ("testLongArray", testLongArray)
  ]
}

Tests.defaultTestSuite.run()
