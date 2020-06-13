func canTwoMovies(in movieLengths: [Int], fillFlight flightLength: Int) -> Bool {
  canTwoMoviesSecondTry(in: movieLengths, fillFlight: flightLength)
}

func canTwoMoviesSecondTry(in movieLengths: [Int], fillFlight flightLength: Int) -> Bool {
  
  var movieLengthsSet = Set<Int>()
  
  for length in movieLengths {
    
    let matchingLength = flightLength - length
    
    if movieLengthsSet.contains(matchingLength) {
      return true
    }
    
    movieLengthsSet.insert(length)
  }
  
  return false
}

func canTwoMoviesFirstTry(in movieLengths: [Int], fillFlight flightLength: Int) -> Bool {
  
  var movieDict: [Int: Int] = [:]
  
  for length in movieLengths {
    
    if movieDict[length] != nil {
    
      movieDict[length]! += 1
      
    } else {
    
      movieDict[length] = 1
      
    }
    
  }
  
  for length in movieLengths {
  
    let otherLength = flightLength - length
    let otherLengthCount = movieDict[otherLength]
    
    if let otherLengthCount = otherLengthCount {
      
      if otherLength == length && otherLengthCount < 2 {
        continue
      }
      
      return true
      
    }
    
  }
  
  return false
}
















// tests

import XCTest

class Tests: XCTestCase {
  
  func testShortFlight() {
    let result = canTwoMovies(in: [2, 4], fillFlight: 1)
    XCTAssertFalse(result)
  }
  
  func testLongFlight() {
    let result = canTwoMovies(in: [2, 4], fillFlight: 6)
    XCTAssertTrue(result)
  }
  
  func testOneMovieHalfFlightLength() {
    let result = canTwoMovies(in: [3, 8], fillFlight: 6)
    XCTAssertFalse(result)
  }
  
  func testTwoMoviesHalfFlightLength() {
    let result = canTwoMovies(in: [3, 8, 3], fillFlight: 6)
    XCTAssertTrue(result)
  }
  
  func testLotsOfPossiblePairs() {
    let result = canTwoMovies(in: [1, 2, 3, 4, 5, 6], fillFlight: 7)
    XCTAssertTrue(result)
  }
  
  func testNotUsingFirstMovie() {
    let result = canTwoMovies(in: [4, 3, 2], fillFlight: 5)
    XCTAssertTrue(result)
  }
  
  func testOnlyOneMovie() {
    let result = canTwoMovies(in: [6], fillFlight: 6)
    XCTAssertFalse(result)
  }
  
  func testNoMovies() {
    let result = canTwoMovies(in: [], fillFlight: 2)
    XCTAssertFalse(result)
  }
  
  static let allTests = [
    ("testShortFlight", testShortFlight),
    ("testLongFlight", testLongFlight),
    ("testOneMovieHalfFlightLength", testOneMovieHalfFlightLength),
    ("testTwoMoviesHalfFlightLength",testTwoMoviesHalfFlightLength),
    ("testLotsOfPossiblePairs", testLotsOfPossiblePairs),
    ("testNotUsingFirstMovie", testNotUsingFirstMovie),
    ("testOnlyOneMovie", testOnlyOneMovie),
    ("testNoMovies", testNoMovies)
  ]
}

Tests.defaultTestSuite.run()
