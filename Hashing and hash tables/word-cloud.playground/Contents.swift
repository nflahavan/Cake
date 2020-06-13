import Foundation

let string = ""
let beginWordIndex = string.startIndex
let endWordIndex = string.endIndex
var substring = string[beginWordIndex..<endWordIndex]
substring = substring.dropFirst()
print(substring)
print(string)


extension Character {
  func isLetter() -> Bool {
    return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(self)
  }
  
  func isWordConnector() -> Bool {
    return "'-".contains(self)
  }
}

class WordCloudData {
  
  private(set) var wordsToCounts: [String: Int] = [:]
  
  init(_ input: String) {
    populateWordsToCounts(input)
  }
  
  private func populateWordsToCounts(_ input: String) {
        
    var beginWordIndex = input.startIndex
    var endWordIndex = beginWordIndex
    
    while true {
      
      let isEndOfInput = endWordIndex == input.endIndex
      
      guard isEndOfInput || !(input[endWordIndex].isLetter() || input[endWordIndex].isWordConnector()) else {
        
        endWordIndex = input.index(after: endWordIndex)
        continue
      }
        
      let wordCandidate = input[beginWordIndex..<endWordIndex].trimmingCharacters(in: CharacterSet(charactersIn: "'-"))
      
      if !wordCandidate.isEmpty {
        
        let word = wordCandidate.lowercased()
        
        if wordsToCounts[word] != nil {
          
          wordsToCounts[word]! += 1
        } else {
          
          wordsToCounts[word] = 1
        }
      }
      
      if endWordIndex == input.endIndex { break }
      endWordIndex = input.index(after: endWordIndex)
      beginWordIndex = endWordIndex
    }
  }
}


















// tests

// there are lots of valid solutions for this one. you
// might have to edit some of these tests if you made
// different design decisions in your solution

import XCTest

class Tests: XCTestCase {
  
  func testSimpleSentence() {
    let input = "I like cake"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["i": 1, "like": 1, "cake": 1]
    XCTAssertEqual(actual, expected)
  }
  
  func testLongerSentence() {
    let input = "Chocolate cake for dinner and pound cake for dessert"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = [
      "and": 1,
      "pound": 1,
      "for": 2,
      "dessert": 1,
      "chocolate": 1,
      "dinner": 1,
      "cake": 2
    ]
    XCTAssertEqual(actual, expected)
  }
  
  func testPunctuation() {
    let input = "Strawberry short cake? Yum!"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["cake": 1, "strawberry": 1, "short": 1, "yum": 1]
    XCTAssertEqual(actual, expected)
  }
  
  func testHyphenatedWords() {
    let input = "Dessert - mille-feuille cake"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["cake": 1, "dessert": 1, "mille-feuille": 1]
    XCTAssertEqual(actual, expected)
  }
  
  func testEllipsesBetweenWords() {
    let input = "Mmm...mmm...decisions...decisions"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["mmm": 2, "decisions": 2]
    XCTAssertEqual(actual, expected)
  }
  
  func testApostrophes() {
    let input = "Allie's Bakery: Sasha's Cakes"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["bakery": 1, "cakes": 1, "allie's": 1, "sasha's": 1]
    XCTAssertEqual(actual, expected)
  }
  
  func testDashOutsideHyphenatedWords() {
    let input = ".. -. - . .-. ...- .. . .-- / -.-. .- -.- . is \"Interview Cake\" in morse code."
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["is": 1, "interview": 1, "cake": 1, "in": 1, "morse": 1, "code": 1]
    XCTAssertEqual(actual, expected)
  }
  
  func testSingleQuoteAfterWord() {
    let input = "Chris' car is very fast."
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = ["chris": 1, "car": 1, "is": 1, "very": 1, "fast": 1]
    XCTAssertEqual(actual, expected)
  }
  
  func testNoValidWords() {
    let input = "1234~!_#!--"
    let wordCloud = WordCloudData(input)
    
    let actual = wordCloud.wordsToCounts
    let expected = [String:Int]()
    XCTAssertEqual(actual, expected)
  }
  
  static let allTests = [
    ("testSimpleSentence", testSimpleSentence),
    ("testLongerSentence", testLongerSentence),
    ("testPunctuation", testPunctuation),
    ("testHyphenatedWords", testHyphenatedWords),
    ("testEllipsesBetweenWords", testEllipsesBetweenWords),
    ("testApostrophes", testApostrophes),
    ("testDashOutsideHyphenatedWords", testDashOutsideHyphenatedWords),
    ("testNoValidWords", testNoValidWords),
    ("testSingleQuoteAfterWord", testSingleQuoteAfterWord)
  ]
}

Tests.defaultTestSuite.run()
