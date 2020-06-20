class BinaryTreeNode {
  
  var value: Int
  var left: BinaryTreeNode?
  var right: BinaryTreeNode?
  
  init(_ value: Int) {
    self.value = value
  }
  
  @discardableResult
  func insert(leftValue: Int) -> BinaryTreeNode {
    left = BinaryTreeNode(leftValue)
    return left!
  }
  
  @discardableResult
  func insert(rightValue: Int) -> BinaryTreeNode {
    right = BinaryTreeNode(rightValue)
    return right!
  }
}

enum InvalidTree: Error {
  case tooSmall
}

func findSecondLargestValue(startingFrom node: BinaryTreeNode) throws -> Int {
  let (largest, parent) = findLargestValueAndParent(startingFrom: node)
  
  if let left = largest.left {
    let (secondLargest, _) = findLargestValueAndParent(startingFrom: left)
    return secondLargest.value
  } else if let parent = parent {
    return parent.value
  } else {
    throw InvalidTree.tooSmall
  }
}

func findLargestValueAndParent(startingFrom node: BinaryTreeNode) -> (BinaryTreeNode, BinaryTreeNode?) {
  var parent: BinaryTreeNode?
  var curr = node
  while true {
    if let right = curr.right {
      parent = curr
      curr = right
    } else {
      return (curr, parent)
    }
  }
}
















// tests

import XCTest

class Tests: XCTestCase {
  
  func testFullTree() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 30)
    left.insert(leftValue: 10)
    left.insert(rightValue: 40)
    let right = root.insert(rightValue: 70)
    right.insert(leftValue: 60)
    right.insert(rightValue: 80)
    
    let actual = try? findSecondLargestValue(startingFrom: root)
    let expected = 70
    XCTAssertEqual(actual, expected)
  }
  
  func testLargestHasALeftChild() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 30)
    left.insert(leftValue: 10)
    left.insert(rightValue: 40)
    let right = root.insert(rightValue: 70)
    right.insert(leftValue: 60)
    
    let actual = try? findSecondLargestValue(startingFrom: root)
    let expected = 60
    XCTAssertEqual(actual, expected)
  }
  
  func testLargestHasALeftSubtree() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 30)
    left.insert(leftValue: 10)
    left.insert(rightValue: 40)
    let right = root.insert(rightValue: 70)
    let rightLeft = right.insert(leftValue: 60)
    rightLeft.insert(leftValue: 55).insert(rightValue: 58)
    rightLeft.insert(rightValue: 65)
    
    let actual = try? findSecondLargestValue(startingFrom: root)
    let expected = 65
    XCTAssertEqual(actual, expected)
  }
  
  func testSecondLargestIsRootNode() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 30)
    left.insert(leftValue: 10)
    left.insert(rightValue: 40)
    root.insert(rightValue: 70)
    
    let actual = try? findSecondLargestValue(startingFrom: root)
    let expected = 50
    XCTAssertEqual(actual, expected)
  }
  
  func testDescendingLinkedList() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 40)
    left.insert(leftValue: 30).insert(leftValue: 20).insert(leftValue: 10)
    
    let actual = try? findSecondLargestValue(startingFrom: root)
    let expected = 40
    XCTAssertEqual(actual, expected)
  }
  
  func testAscendingLinkedList() {
    let root = BinaryTreeNode(50)
    let right = root.insert(rightValue: 60)
    right.insert(rightValue: 70).insert(rightValue: 80)
    
    let actual = try? findSecondLargestValue(startingFrom: root)
    let expected = 70
    XCTAssertEqual(actual, expected)
  }
  
  func testThrowsErrorWhenTreeHasOneNode() {
    let root = BinaryTreeNode(50)
    
    let result = try? findSecondLargestValue(startingFrom: root)
    XCTAssertNil(result)
  }
  
  static let allTests = [
    ("testFullTree", testFullTree),
    ("testLargestHasALeftChild", testLargestHasALeftChild),
    ("testLargestHasALeftSubtree", testLargestHasALeftSubtree),
    ("testSecondLargestIsRootNode", testSecondLargestIsRootNode),
    ("testDescendingLinkedList", testDescendingLinkedList),
    ("testAscendingLinkedList", testAscendingLinkedList),
    ("testThrowsErrorWhenTreeHasOneNode", testThrowsErrorWhenTreeHasOneNode)
  ]
}

Tests.defaultTestSuite.run()
