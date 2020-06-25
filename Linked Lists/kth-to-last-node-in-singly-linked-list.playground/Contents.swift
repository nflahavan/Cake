class LinkedListNode<Value: Equatable> {
  
  var value: Value
  var next: LinkedListNode?
  
  init(_ value: Value) {
    self.value = value
  }
}

enum InvalidK: Error {
  case of(Int)
}

enum InvalidList: Error {
  case smallerThan(Int)
}

func kthToLastNode(at k: Int, forHead head: LinkedListNode<Int>) throws -> LinkedListNode<Int> {
  // Start at head
  // walk a step and count
  // keep walking until you walk k steps.
  // start walking at start again, same pace as before
  // once you reach the end, you've found it.
  // if you reach the end before you reach k, throw
  guard k > 0 else { throw InvalidK.of(k) }
  
  var tip = head
  var feathers = head
  
  for _ in 0..<(k - 1) {
    guard let next = tip.next else { throw InvalidList.smallerThan(k) }
    tip = next
  }
  
  while let next = tip.next {
    tip = next
    feathers = feathers.next!
  }
  
  return feathers
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testFirstToLastNode() {
    let nodes = linkedListNodes(from: [1, 2, 3, 4])
    let actual = try? kthToLastNode(at: 1, forHead: nodes[0])
    let expected = nodes[3]
    XCTAssertTrue(actual === expected)
  }
  
  func testSecondToLastNode() {
    let nodes = linkedListNodes(from: [1, 2, 3, 4])
    let actual = try? kthToLastNode(at: 2, forHead: nodes[0])
    let expected = nodes[2]
    XCTAssertTrue(actual === expected)
  }
  
  func testFirstNode() {
    let nodes = linkedListNodes(from: [1, 2, 3, 4])
    let actual = try? kthToLastNode(at: 4, forHead: nodes[0])
    let expected = nodes[0]
    XCTAssertTrue(actual === expected)
  }
  
  func testKGreaterThanLinkedListLength() {
    let nodes = linkedListNodes(from: [1, 2, 3, 4])
    do {
      let _ = try kthToLastNode(at: 5, forHead: nodes[0])
      XCTFail()
    } catch {
      // test passed
    }
  }
  
  func testKIsZero() {
    let nodes = linkedListNodes(from: [1, 2, 3, 4])
    do {
      let _ = try kthToLastNode(at: 0, forHead: nodes[0])
      XCTFail()
    } catch {
      // test passed
    }
  }
  
  private func linkedListNodes(from values: [Int]) -> [LinkedListNode<Int>] {
    var nodes: [LinkedListNode<Int>] = []
    for (index, value) in values.enumerated() {
      nodes.append(LinkedListNode<Int>(value))
      if index > 0 {
        nodes[index - 1].next = nodes[index]
      }
    }
    return nodes
  }
  
  static let allTests = [
    ("testFirstToLastNode", testFirstToLastNode),
    ("testSecondToLastNode", testSecondToLastNode),
    ("testFirstNode", testFirstNode),
    ("testKGreaterThanLinkedListLength", testKGreaterThanLinkedListLength),
    ("testKIsZero", testKIsZero)
  ]
}

Tests.defaultTestSuite.run()
