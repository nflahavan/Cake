import Foundation

func mergeArrays(_ myArray: [Int], _ alicesArray: [Int]) -> [Int] {
  
  var mergedArray: [Int] = []
  mergedArray.reserveCapacity(myArray.count + alicesArray.count)
  
  var my = 0
  var alice = 0
  
  while my < myArray.count {
    
    guard alice < alicesArray.count else {
      
      let remainingFromMine = myArray[my...]
      mergedArray.append(contentsOf: remainingFromMine)
      break
    }
    
    if myArray[my] < alicesArray[alice] {
    
      mergedArray.append(myArray[my])
      my += 1
      
    } else {
      
      mergedArray.append(alicesArray[alice])
      alice += 1
    }
  }
  
  if alice < alicesArray.count {
    
    let remainingFromAlice = alicesArray[alice...]
    mergedArray.append(contentsOf: remainingFromAlice)
  }
  
  return mergedArray
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testBothArraysAreEmpty() {
    let myArray: [Int] = []
    let alicesArray: [Int] = []
    let actual = mergeArrays(myArray, alicesArray)
    let expected: [Int] = []
    XCTAssertEqual(actual, expected)
  }
  
  func testFirstArrayIsEmpty() {
    let myArray: [Int] = []
    let alicesArray = [1, 2, 3]
    let actual = mergeArrays(myArray, alicesArray)
    let expected = [1, 2, 3]
    XCTAssertEqual(actual, expected)
  }
  
  func testSecondArrayIsEmpty() {
    let myArray = [5, 6, 7]
    let alicesArray: [Int] = []
    let actual = mergeArrays(myArray, alicesArray)
    let expected = [5, 6, 7]
    XCTAssertEqual(actual, expected)
  }
  
  func testBothArraysHaveSomeNumbers() {
    let myArray = [2, 4, 6]
    let alicesArray = [1, 3, 7]
    let actual = mergeArrays(myArray, alicesArray)
    let expected = [1, 2, 3, 4, 6, 7]
    XCTAssertEqual(actual, expected)
  }
  
  func testArraysAreDifferentLengths() {
    let myArray = [2, 4, 6, 8]
    let alicesArray = [1, 7]
    let actual = mergeArrays(myArray, alicesArray)
    let expected = [1, 2, 4, 6, 7, 8]
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testBothArraysAreEmpty", testBothArraysAreEmpty),
    ("testFirstArrayIsEmpty", testFirstArrayIsEmpty),
    ("testSecondArrayIsEmpty", testSecondArrayIsEmpty),
    ("testBothArraysHaveSomeNumbers", testBothArraysHaveSomeNumbers),
    ("testArraysAreDifferentLengths", testArraysAreDifferentLengths)
  ]
}

Tests.defaultTestSuite.run()
