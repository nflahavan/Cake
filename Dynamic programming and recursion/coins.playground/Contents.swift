func changePossibilities(amount: Int, denominations: [Int]) -> Int {
  var memo = [Int:[[Int]:Int]]()
  
  func memoChangePoss(_ amount: Int, _ denominations: [Int]) -> Int {
    
    guard amount > 0 else { return 1 }
    guard !denominations.isEmpty else { return 0 }
    if let poss = memo[amount]?[denominations] { return poss }
    
    let sortedDenominations = denominations.sorted()
    let lowestDenomination = sortedDenominations.first!
    let otherDenominations = Array(denominations[1..<denominations.endIndex])
    var numLowestDenom = amount / lowestDenomination
    var poss = 0
    
    while numLowestDenom >= 0 {
      let remainder = amount - numLowestDenom * lowestDenomination
      poss += memoChangePoss(remainder, otherDenominations)
      numLowestDenom -= 1
    }
    
    if memo[amount] != nil {
      memo[amount]?[denominations] = poss
    } else {
      memo[amount] = [denominations: poss]
    }
    
    return poss
  }
  
  return memoChangePoss(amount, denominations)
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testSampleInput() {
    let actual = changePossibilities(amount: 4, denominations: [1, 2, 3])
    let expected = 4
    XCTAssertEqual(actual, expected)
  }
  
  func testOneWayToMakeZeroCents() {
    let actual = changePossibilities(amount: 0, denominations: [1, 2])
    let expected = 1
    XCTAssertEqual(actual, expected)
  }
  
  func testNoWaysIfNoCoins() {
    let actual = changePossibilities(amount: 1, denominations: [])
    let expected = 0
    XCTAssertEqual(actual, expected)
  }
  
  func testBigCoinValue() {
    let actual = changePossibilities(amount: 5, denominations: [25, 50])
    let expected = 0
    XCTAssertEqual(actual, expected)
  }
  
  func testBigTargetAmount() {
    let actual = changePossibilities(amount: 50, denominations: [5, 10])
    let expected = 6
    XCTAssertEqual(actual, expected)
  }
  
  func testChangeForOneDollar() {
    let actual = changePossibilities(amount: 100, denominations: [1, 5, 10, 25, 50])
    let expected = 292
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testSampleInput", testSampleInput),
    ("testOneWayToMakeZeroCents", testOneWayToMakeZeroCents),
    ("testNoWaysIfNoCoins", testNoWaysIfNoCoins),
    ("testBigCoinValue", testBigCoinValue),
    ("testBigTargetAmount", testBigTargetAmount),
    ("testChangeForOneDollar", testChangeForOneDollar)
  ]
}

Tests.defaultTestSuite.run()
