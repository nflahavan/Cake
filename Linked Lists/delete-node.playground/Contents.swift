class LinkedListNode<Value: Equatable> {
  
  var value: Value
  var next: LinkedListNode<Value>?
  
  init(_ value: Value, next: LinkedListNode? = nil) {
    self.value = value
    self.next = next
  }
  
}

enum Bad: Error {
  case bad
}

func deleteNode<T>(_ nodeToDelete: LinkedListNode<T>) throws {
  
  // normally you delete a node
  // by setting it's previous's next equal to it's next
  // and removing all references to it, so ARC collects it
  // we can't do that here.
  
  // instead we can move each node up
  // so that next's value is now in curr, and so on until we hit a point
  // where there is no next.
  // then we make sure to remove the reference to the last node
  
  // So we need to keep track of prev, after our first "removal"
  // if there is no next, I guess we throw?
  // because we cannot delete the "last" node in a list
  
  // What is time/space?
  
  // time is O(n) because we could be asked to delete first node
  // in which case we iterate through whole list
  
  // space is O(1), we just keep track of one extra node
  // regardless of size of input
  
  // can we do better?
  // we could set nodeToDelete's value = next.value
  // then set node to delete's next = next's next
  // that'd be O(1) space and time
  
  guard let next = nodeToDelete.next else {
    throw Bad.bad
  }
  
  nodeToDelete.value = next.value
  nodeToDelete.next = next.next
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  var first, second, third, fourth: LinkedListNode<Int>!
  
  override func setUp() {
    fourth = LinkedListNode(4)
    third  = LinkedListNode(3, next: fourth)
    second = LinkedListNode(2, next: third)
    first  = LinkedListNode(1, next: second)
  }
  
  func testNodeAtBeginning() throws {
    try deleteNode(first)
    let actual = values(from: first)
    let expected = [2, 3, 4]
    XCTAssertEqual(actual, expected)
  }
  
  func testNodeInTheMiddle() throws {
    try deleteNode(second)
    let actual = values(from: first)
    let expected = [1, 3, 4]
    XCTAssertEqual(actual, expected)
  }
  
  func testNodeAtTheEnd() {
    do {
      try deleteNode(fourth)
      XCTFail()
    } catch {
      // test passed
    }
  }
  
  func testOneNodeList() {
    let head = LinkedListNode(1)
    do {
      try deleteNode(head)
      XCTFail()
    } catch {
      // test passed
    }
  }
  
  func values(from head: LinkedListNode<Int>) -> [Int] {
    var values: [Int] = []
    var current: LinkedListNode! = head
    while current != nil {
      values.append(current.value)
      current = current.next
    }
    return values
  }
  
  static let allTests = [
    ("testNodeAtBeginning", testNodeAtBeginning),
    ("testNodeInTheMiddle", testNodeInTheMiddle),
    ("testNodeAtTheEnd", testNodeAtTheEnd),
    ("testOneNodeList", testOneNodeList)
  ]
}

Tests.defaultTestSuite.run()
