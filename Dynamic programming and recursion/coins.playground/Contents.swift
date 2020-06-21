// SOURCE: https://www.interviewcake.com/question/swift/coin?course=fc1&section=dynamic-programming-recursion

func changePossibilitiesDynamic(amount: Int, denominations: [Int]) -> Int {
  var waysOfDoing = Array(repeating: 0, count: amount + 1)
  waysOfDoing[0] = 1
  
  for denomination in denominations {
    if denomination <= amount {
      for higherAmount in denomination...amount {
        let higherAmountRemainder = higherAmount - denomination
        waysOfDoing[higherAmount] += waysOfDoing[higherAmountRemainder]
      }
    }
  }
  
  return waysOfDoing[amount]
}

func changePossibilitiesRecursiveMemoized(amount: Int, denominations: [Int]) -> Int {
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

class ProvidedRecursiveMemoized {
  
  private var memo: [String: Int] = [:]
  private var denominations: [Int] = []
  
  func changePossibilitiesTopDown(amountLeft: Int, denominations: [Int]) -> Int {
    return changePossibilitiesTopDown(amountLeft: amountLeft, denominations: denominations, currentIndex: 0)
  }
  
  func changePossibilitiesTopDown(amountLeft: Int, denominations: [Int], currentIndex: Int) -> Int {
    
    // check our memo and short-circuit if we've already solved this one
    let memoKey = "\(amountLeft), \(currentIndex)"
    if let memoValue = memo[memoKey] {
      return memoValue
    }
    
    // base cases:
    // we hit the amount spot on. yes!
    if amountLeft == 0 {
      return 1
    }
    
    // we overshot the amount left (used too many coins)
    if amountLeft < 0 {
      return 0
    }
    
    // we're out of denominations
    if currentIndex == denominations.count {
      return 0
    }
        
    // choose a current coin
    let currentCoin = denominations[currentIndex]
    
    // see how many possibilities we can get
    // for each number of times to use currentCoin
    var numPossibilities = 0
    var amountLeftInner = amountLeft
    while amountLeftInner >= 0  {
      numPossibilities += changePossibilitiesTopDown(amountLeft: amountLeftInner, denominations: denominations,
                                                     currentIndex: currentIndex + 1)
      amountLeftInner -= currentCoin
    }
    
    // save the answer in our memo so we don't compute it again
    memo[memoKey] = numPossibilities
    
    return numPossibilities
  }
}

func changePossibilities(amount: Int, denominations: [Int]) -> Int {
  //changePossibilitiesRecursiveMemoized(amount: amount, denominations: denominations)
  changePossibilitiesDynamic(amount: amount, denominations: denominations)
  //ProvidedRecursiveMemoized().changePossibilitiesTopDown(amountLeft: amount, denominations: denominations)
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
