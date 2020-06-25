class LinkedListNode<Value: Equatable> {
  
  var value: Value
  var next: LinkedListNode?
  
  init(_ value: Value) {
    self.value = value
  }
}

func reverseLinkedList<Value>(startingFrom headOfList: LinkedListNode<Value>?) -> LinkedListNode<Value>? {
  
  // reverse the linked list in place
  guard var curr = headOfList, var next = curr.next else { return headOfList }
  curr.next = nil
  
  while true {
    let nextNext = next.next
    
    next.next = curr
    curr = next
    
    if let nextNext = nextNext {
      next = nextNext
    } else {
      return next
    }
  }
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testShortLinkedList() {
    let nodes = linkedListNodes(from: [1, 2])
    let result = reverseLinkedList(startingFrom: nodes[0])
    XCTAssertTrue(isListReversed(list: result, originalNodes: nodes))
  }
  
  func testLongLinkedList() {
    let nodes = linkedListNodes(from: [1, 2, 3, 4, 5, 6])
    let result = reverseLinkedList(startingFrom: nodes[0])
    XCTAssertTrue(isListReversed(list: result, originalNodes: nodes))
  }
  
  func testOneElementLinkedList() {
    let node = LinkedListNode(1)
    let result = reverseLinkedList(startingFrom: node)
    XCTAssertTrue(node === result)
  }
  
  func testEmptyLinkedList() {
    let nilList: LinkedListNode<Int>? = nil
    let result = reverseLinkedList(startingFrom: nilList)
    XCTAssertNil(result)
  }
  
  private func linkedListNodes(from values: [Int]) -> [LinkedListNode<Int>] {
    var nodes: [LinkedListNode<Int>] = []
    for (index, value) in values.enumerated() {
      nodes.append(LinkedListNode(value))
      if index > 0 {
        nodes[index - 1].next = nodes[index]
      }
    }
    return nodes
  }
  
  private func isListReversed(list: LinkedListNode<Int>?, originalNodes: [LinkedListNode<Int>]) -> Bool {
    var currentNode = list
    for node in originalNodes.reversed() {
      if currentNode !== node {
        return false
      }
      currentNode = currentNode?.next
    }
    return currentNode == nil
  }
  
  static let allTests = [
    ("testShortLinkedList", testShortLinkedList),
    ("testLongLinkedList", testLongLinkedList),
    ("testOneElementLinkedList", testOneElementLinkedList),
    ("testEmptyLinkedList", testEmptyLinkedList)
  ]
}

Tests.defaultTestSuite.run()
