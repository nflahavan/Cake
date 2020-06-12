func isFirstComeFirstServed(takeOutOrders: [Int], dineInOrders: [Int], servedOrders: [Int]) -> Bool {
  
  var indexNextTakeout = 0
  var indexNextDin = 0
  
  for order in servedOrders {
    
    if indexNextTakeout < takeOutOrders.count, takeOutOrders[indexNextTakeout] == order {
      
      indexNextTakeout += 1
      continue
    } else if indexNextDin < dineInOrders.count, dineInOrders[indexNextDin] == order {
      
      indexNextDin += 1
      continue
    } else {
      
      return false
    }
  }
  
  return !(indexNextDin < dineInOrders.count || indexNextTakeout < takeOutOrders.count)
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testBothRegistersHaveSameNumberOfOrders() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [1, 4, 5],
      dineInOrders: [2, 3, 6],
      servedOrders: [1, 2, 3, 4, 5, 6]
    )
    XCTAssertTrue(result)
  }
  
  func testRegistersHaveDifferentLengths() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [1, 5],
      dineInOrders: [2, 3, 6],
      servedOrders: [1, 2, 6, 3, 5]
    )
    XCTAssertFalse(result)
  }
  
  func testOneRegisterIsEmpty() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [],
      dineInOrders: [2, 3, 6],
      servedOrders: [2, 3, 6]
    )
    XCTAssertTrue(result)
  }
  
  func testServedOrdersIsMissingOrders() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [1, 5],
      dineInOrders: [2, 3, 6],
      servedOrders: [1, 6, 3, 5]
    )
    XCTAssertFalse(result)
  }
  
  func testServedOrdersHasExtraOrders() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [1, 5],
      dineInOrders: [2, 3, 6],
      servedOrders: [1, 2, 3, 5, 6, 8]
    )
    XCTAssertFalse(result)
  }
  
  func testOneRegisterHasExtraOrders() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [1, 9],
      dineInOrders: [7, 8],
      servedOrders: [1, 7, 8]
    )
    XCTAssertFalse(result)
  }
  
  func testOneRegisterHasUnservedOrders() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [55, 9],
      dineInOrders: [7, 8],
      servedOrders: [1, 7, 8, 9]
    )
    XCTAssertFalse(result)
  }
  
  func testOrderNumbersAreNotSequential() {
    let result = isFirstComeFirstServed(
      takeOutOrders: [27, 12, 18],
      dineInOrders: [55, 31, 8],
      servedOrders: [55, 31, 8, 27, 12, 18]
    )
    XCTAssertTrue(result)
  }
  
  static let allTests = [
    ("testBothRegistersHaveSameNumberOfOrders", testBothRegistersHaveSameNumberOfOrders),
    ("testRegistersHaveDifferentLengths", testRegistersHaveDifferentLengths),
    ("testOneRegisterIsEmpty", testOneRegisterIsEmpty),
    ("testServedOrdersIsMissingOrders", testServedOrdersIsMissingOrders),
    ("testServedOrdersHasExtraOrders", testServedOrdersHasExtraOrders),
    ("testOneRegisterHasExtraOrders", testOneRegisterHasExtraOrders),
    ("testOneRegisterHasUnservedOrders", testOneRegisterHasUnservedOrders),
    ("testOrderNumbersAreNotSequential", testOrderNumbersAreNotSequential)
  ]
}

Tests.defaultTestSuite.run()
