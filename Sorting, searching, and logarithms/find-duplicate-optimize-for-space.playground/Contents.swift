import Foundation

func findRepeat(in numbers: [Int]) -> Int {

    // find a number that appears more than once
    var floor = -1
    var ceiling = numbers.count
    while floor + 2 < ceiling {
        let distance = ceiling - floor
        let halfDistance = distance / 2
        let tempFloor = ceiling - halfDistance
        var numOccurances = 0
        for num in numbers {
            if num >= tempFloor && num < ceiling {
                numOccurances += 1
            }
        }
        let expectedOccurances = halfDistance
        if numOccurances > expectedOccurances {
            floor = tempFloor - 1
        } else {
            ceiling = tempFloor
        }
    }

    return floor + 1
}


















// tests

import XCTest

class Tests: XCTestCase {

    func testJustTheRepeatedNumber() {
        let numbers = [1, 1]
        let actual = findRepeat(in: numbers)
        let expected = 1
        XCTAssertEqual(actual, expected)
    }

    func testShortArray() {
        let numbers = [1, 2, 3, 2]
        let actual = findRepeat(in: numbers)
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testMediumArray() {
        let numbers = [1, 2, 5, 5, 5, 5]
        let actual = findRepeat(in: numbers)
        let expected = 5
        XCTAssertEqual(actual, expected)
    }

    func testLongArray() {
        let numbers = [4, 1, 4, 8, 3, 2, 7, 6, 5]
        let actual = findRepeat(in: numbers)
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
