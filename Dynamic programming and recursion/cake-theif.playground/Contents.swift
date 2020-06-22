struct CakeType {
  let weight: UInt
  let value: UInt
}

enum Bad: Error {
  case bad
}

func maxDuffelBagValue(
  for cakeTypes: [CakeType],
  withCapacity weightCapacity: UInt
) throws -> UInt {
  
  guard weightCapacity > 0 else { return 0 }
  // solve it similar to the solution we came up with for the denominations
  // problem, except somehow keep track of value

  var valueForBagSizeN = Array(repeating: 0, count: Int(weightCapacity) + 1)
  
  for bagSize in 0..<valueForBagSizeN.count {
    
    for cake in cakeTypes where Int(cake.weight) <= bagSize {
      
      if cake.weight == 0 && cake.value > 0 { throw Bad.bad }
      
      valueForBagSizeN[bagSize] = max(
        Int(cake.value) + valueForBagSizeN[bagSize - Int(cake.weight)],
        valueForBagSizeN[bagSize]
      )
    }
  }
  
  return UInt(valueForBagSizeN.last!)
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testOneCake() {
    let actual = try? maxDuffelBagValue(for: [CakeType(weight: 2, value: 1)], withCapacity: 9)
    let expected: UInt = 4
    XCTAssertEqual(actual, expected)
  }
  
  func testTwoCakes() {
    let cakeTypes = [
      CakeType(weight: 4, value: 4),
      CakeType(weight: 5, value: 5)
    ]
    let actual = try? maxDuffelBagValue(for: cakeTypes, withCapacity: 9)
    let expected: UInt = 9
    XCTAssertEqual(actual, expected)
  }
  
  func testOnlyTakeLessValuableCake() {
    let cakeTypes = [
      CakeType(weight: 4, value: 4),
      CakeType(weight: 5, value: 5)
    ]
    let actual = try? maxDuffelBagValue(for: cakeTypes, withCapacity: 12)
    let expected: UInt = 12
    XCTAssertEqual(actual, expected)
  }
  
  func testLotsOfCakes() {
    let cakeTypes = [
      CakeType(weight: 2, value: 3),
      CakeType(weight: 3, value: 6),
      CakeType(weight: 5, value: 1),
      CakeType(weight: 6, value: 1),
      CakeType(weight: 7, value: 1),
      CakeType(weight: 8, value: 1)
    ]
    let actual = try? maxDuffelBagValue(for: cakeTypes, withCapacity: 7)
    let expected: UInt = 12
    XCTAssertEqual(actual, expected)
  }
  
  func testValueToWeightRatioIsNotOptimal() {
    let cakeTypes = [
      CakeType(weight: 51, value: 52),
      CakeType(weight: 50, value: 50)
    ]
    let actual = try? maxDuffelBagValue(for: cakeTypes, withCapacity: 100)
    let expected: UInt = 100
    XCTAssertEqual(actual, expected)
  }
  
  func testZeroCapacity() {
    let actual = try? maxDuffelBagValue(for: [CakeType(weight: 1, value: 2)], withCapacity: 0)
    let expected: UInt = 0
    XCTAssertEqual(actual, expected)
  }
  
  func testCakeWithZeroValueAndWeight() {
    let cakeTypes = [
      CakeType(weight: 0, value: 0),
      CakeType(weight: 2, value: 1)
    ]
    let actual = try? maxDuffelBagValue(for: cakeTypes, withCapacity: 7)
    let expected: UInt = 3
    XCTAssertEqual(actual, expected)
  }
  
  func testCallWithCakeWithNonZeroValueAndZeroWeight() {
    let actual = try? maxDuffelBagValue(for: [CakeType(weight: 0, value: 5)], withCapacity: 5)
    XCTAssertNil(actual)
  }
  
  static let allTests = [
    ("testOneCake", testOneCake),
    ("testTwoCakes", testTwoCakes),
    ("testOnlyTakeLessValuableCake", testOnlyTakeLessValuableCake),
    ("testLotsOfCakes", testLotsOfCakes),
    ("testValueToWeightRatioIsNotOptimal", testValueToWeightRatioIsNotOptimal),
    ("testZeroCapacity", testZeroCapacity),
    ("testCakeWithZeroValueAndWeight", testCakeWithZeroValueAndWeight),
    ("testCallWithCakeWithNonZeroValueAndZeroWeight", testCallWithCakeWithNonZeroValueAndZeroWeight)
  ]
}

Tests.defaultTestSuite.run()
