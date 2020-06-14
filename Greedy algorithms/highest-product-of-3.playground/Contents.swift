func highestProductOf3(_ items: [Int]) throws -> Int {

  enum AnError: Error {
    case notEnoughItems
  }

  guard items.count > 2 else {
    throw AnError.notEnoughItems
  }

  let firstThreeSorted = items[0...2].sorted()

  var highest = firstThreeSorted[2]
  var secondHighest = firstThreeSorted[1]
  var thirdHighest = firstThreeSorted[0]
  var lowest = firstThreeSorted[0]
  var secondLowest = firstThreeSorted[1]

  for item in items[3...] {

    var inQuestion = item

    if inQuestion > highest {

      let temp = highest
      highest = inQuestion
      inQuestion = temp
    }

    if inQuestion > secondHighest {

      let temp = secondHighest
      secondHighest = inQuestion
      inQuestion = temp
    }

    if inQuestion > thirdHighest {

      let temp = thirdHighest
      thirdHighest = inQuestion
      inQuestion = temp
    }
    
    inQuestion = item

    if inQuestion < lowest {

      let temp = lowest
      lowest = inQuestion
      inQuestion = temp
    }

    if inQuestion < secondLowest {

      secondLowest = inQuestion
    }
  }
  
  let productOfHighests = highest * secondHighest * thirdHighest
  let productOfTwoLowestsAndHighest = highest * lowest * secondLowest
  return productOfHighests > productOfTwoLowestsAndHighest ? productOfHighests : productOfTwoLowestsAndHighest
}












// tests

import XCTest

class Tests: XCTestCase {
  
  func testShortArray() {
    let actual = try? highestProductOf3([1, 2, 3, 4])
    let expected = 24
    XCTAssertEqual(actual, expected)
  }
  
  func testLongerArray() {
    let actual = try? highestProductOf3([6, 1, 3, 5, 7, 8, 2])
    let expected = 336
    XCTAssertEqual(actual, expected)
  }
  
  func testArrayHasOneNegative() {
    let actual = try? highestProductOf3([-5, 4, 8, 2, 3])
    let expected = 96
    XCTAssertEqual(actual, expected)
  }
  
  func testArrayHasTwoNegatives() {
    let actual = try? highestProductOf3([-10, 1, 3, 2, -10])
    let expected = 300
    XCTAssertEqual(actual, expected)
  }
  
  func testArrayIsAllNegatives() {
    let actual = try? highestProductOf3([-5, -1, -3, -2])
    let expected = -6
    XCTAssertEqual(actual, expected)
  }
  
  func testErrorWithEmptyArray() {
    let actual = try? highestProductOf3([])
    let expected: Int? = nil
    XCTAssertEqual(actual, expected)
  }
  
  func testErrorWithOneNumber() {
    let actual = try? highestProductOf3([1])
    let expected: Int? = nil
    XCTAssertEqual(actual, expected)
  }
  
  func testErrorWithTwoNumbers() {
    let actual = try? highestProductOf3([1, 1])
    let expected: Int? = nil
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testShortArray", testShortArray),
    ("testLongerArray", testLongerArray),
    ("testArrayHasOneNegative", testArrayHasOneNegative),
    ("testArrayHasTwoNegatives", testArrayHasTwoNegatives),
    ("testArrayIsAllNegatives", testArrayIsAllNegatives),
    ("testErrorWithEmptyArray", testErrorWithEmptyArray),
    ("testErrorWithOneNumber", testErrorWithOneNumber),
    ("testErrorWithTwoNumbers", testErrorWithTwoNumbers)
  ]
}

Tests.defaultTestSuite.run()
