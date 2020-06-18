class BinaryTreeNode {
  
  var value: Int
  var left: BinaryTreeNode?
  var right: BinaryTreeNode?
  
  init(_ value: Int) {
    self.value = value
  }
  
  @discardableResult
  func insert(leftValue: Int) -> BinaryTreeNode {
    let left = BinaryTreeNode(leftValue)
    self.left = left
    return left
  }
  
  @discardableResult
  func insert(rightValue: Int) -> BinaryTreeNode {
    let right = BinaryTreeNode(rightValue)
    self.right = right
    return right
  }
}

func isBinarySearchTree(_ tree: BinaryTreeNode) -> Bool {
  
  // determine if the tree is a valid binary search tree
  var stack = [(tree, Int.min...Int.max)]
  while let curr = stack.popLast() {
    guard curr.1.contains(curr.0.value) else { return false }
    if let left = curr.0.left {
      stack.append((left, curr.1.lowerBound...curr.0.value))
    }
    if let right = curr.0.right {
      stack.append((right, curr.0.value...curr.1.upperBound))
    }
  }
  return true
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testValidFullTree() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 30)
    left.insert(leftValue: 10)
    left.insert(rightValue: 40)
    let right = root.insert(rightValue: 70)
    right.insert(leftValue: 60)
    right.insert(rightValue: 80)
    
    let result = isBinarySearchTree(root)
    XCTAssertTrue(result)
  }
  
  func testBothSubtreesValid() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 30)
    left.insert(leftValue: 20)
    left.insert(rightValue: 60)
    let right = root.insert(rightValue: 80)
    right.insert(leftValue: 70)
    right.insert(rightValue: 90)
    
    let result = isBinarySearchTree(root)
    XCTAssertFalse(result)
  }
  
  func testDescendingLinkedList() {
    let root = BinaryTreeNode(50)
    let left = root.insert(leftValue: 40)
    let leftLeft = left.insert(leftValue: 30)
    let leftLeftLeft = leftLeft.insert(leftValue: 20)
    leftLeftLeft.insert(leftValue: 10)
    
    let result = isBinarySearchTree(root)
    XCTAssertTrue(result)
  }
  
  func testOutOfOrderLinkedList() {
    let root = BinaryTreeNode(50)
    let right = root.insert(leftValue: 70)
    let rightRight = right.insert(leftValue: 60)
    rightRight.insert(leftValue: 80)
    
    let result = isBinarySearchTree(root)
    XCTAssertFalse(result)
  }
  
  func testOneNodeTree() {
    let root = BinaryTreeNode(50)
    
    let result = isBinarySearchTree(root)
    XCTAssertTrue(result)
  }
  
  static let allTests = [
    ("testValidFullTree", testValidFullTree),
    ("testBothSubtreesValid", testBothSubtreesValid),
    ("testDescendingLinkedList", testDescendingLinkedList),
    ("testOutOfOrderLinkedList", testOutOfOrderLinkedList),
    ("testOneNodeTree", testOneNodeTree)
  ]
}

Tests.defaultTestSuite.run()
