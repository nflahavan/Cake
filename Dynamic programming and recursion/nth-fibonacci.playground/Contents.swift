func fib(_ n: UInt) -> UInt {
  var memo: [UInt: UInt] = [0: 0, 1: 1]
  
  func memoFib(_ n: UInt) -> UInt {
    if let fib = memo[n] { return fib }
    
    memo[n - 1] = memoFib(n - 1)
    memo[n - 2] = memoFib(n - 2)
    
    return memo[n - 1]! + memo[n - 2]!
  }
  
  return memoFib(n)
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testZerothFibonacci() {
    let actual = fib(0)
    let expected: UInt = 0
    XCTAssertEqual(actual, expected)
  }
  
  func testFirstFibonacci() {
    let actual = fib(1)
    let expected: UInt = 1
    XCTAssertEqual(actual, expected)
  }
  
  func testSecondFibonacci() {
    let actual = fib(2)
    let expected: UInt = 1
    XCTAssertEqual(actual, expected)
  }
  
  func testThirdFibonacci() {
    let actual = fib(3)
    let expected: UInt = 2
    XCTAssertEqual(actual, expected)
  }
  
  func testFifthFibonacci() {
    let actual = fib(5)
    let expected: UInt = 5
    XCTAssertEqual(actual, expected)
  }
  
  func testTenthFibonacci() {
    let actual = fib(10)
    let expected: UInt = 55
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testZerothFibonacci", testZerothFibonacci),
    ("testFirstFibonacci", testFirstFibonacci),
    ("testSecondFibonacci", testSecondFibonacci),
    ("testThirdFibonacci", testThirdFibonacci),
    ("testFifthFibonacci", testFifthFibonacci),
    ("testTenthFibonacci", testTenthFibonacci)
  ]
}

Tests.defaultTestSuite.run()
