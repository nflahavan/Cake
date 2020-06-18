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

func isBalanced(treeRoot: BinaryTreeNode) -> Bool {
  secondTry(treeRoot)
}

func secondTry(_ root: BinaryTreeNode) -> Bool {
  var stack = [(root, 0)]
  var maxLeafDepth: Int?
  while let curr = stack.popLast() {
    if let left = curr.0.left, let right = curr.0.right {
      stack.append((left, curr.1 + 1))
      stack.append((right, curr.1 + 1))
    } else if let left = curr.0.left {
      stack.append((left, curr.1 + 1))
    } else if let right = curr.0.right {
      stack.append((right, curr.1 + 1))
    } else if let maxLeaf = maxLeafDepth {
      guard abs(maxLeaf - curr.1) < 2 else {
        return false
      }
      maxLeafDepth = max(maxLeaf, curr.1)
    } else {
      maxLeafDepth = curr.1
    }
  }
  return true
}

func firstTry(_ root: BinaryTreeNode) -> Bool {
  // determine if the tree is superbalanced
  func minMaxLeafDepth(from root: BinaryTreeNode) -> (Int, Int) {
    if let left = root.left, let right = root.right {
      let minMaxLeft = minMaxLeafDepth(from: left)
      let minMaxRight = minMaxLeafDepth(from: right)
      let minn = min(minMaxLeft.0, minMaxRight.0) + 1
      let maxx = max(minMaxLeft.1, minMaxRight.1) + 1
      return (minn, maxx)
    } else if let left = root.left {
      var minMax = minMaxLeafDepth(from: left)
      minMax.0 += 1
      minMax.1 += 1
      return minMax
    } else if let right = root.right {
      var minMax = minMaxLeafDepth(from: right)
      minMax.0 += 1
      minMax.1 += 1
      return minMax
    } else {
      return (0,0)
    }
  }
  
  let minMax = minMaxLeafDepth(from: root)
  return (minMax.1 - minMax.0) <= 1
}















// tests

import XCTest

class Tests: XCTestCase {
  
  func testFullTree() {
    let treeRoot = BinaryTreeNode(5)
    let leftNode = treeRoot.insert(leftValue: 8)
    leftNode.insert(leftValue: 1)
    leftNode.insert(rightValue: 2)
    let rightNode = treeRoot.insert(rightValue: 6)
    rightNode.insert(leftValue: 3)
    rightNode.insert(rightValue: 4)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertTrue(result)
  }
  
  func testBothLeavesAtTheSameDepth() {
    let treeRoot = BinaryTreeNode(3)
    let leftNode = treeRoot.insert(leftValue: 4)
    leftNode.insert(leftValue: 1)
    let rightNode = treeRoot.insert(rightValue: 2)
    rightNode.insert(rightValue: 9)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertTrue(result)
  }
  
  func testLeafHeightsDifferByOne() {
    let treeRoot = BinaryTreeNode(6)
    treeRoot.insert(leftValue: 1)
    let rightNode = treeRoot.insert(rightValue: 0)
    rightNode.insert(rightValue: 7)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertTrue(result)
  }
  
  func testLeafHeightsDifferByTwo() {
    let treeRoot = BinaryTreeNode(6)
    treeRoot.insert(leftValue: 1)
    let rightNode = treeRoot.insert(rightValue: 0)
    rightNode.insert(rightValue: 7).insert(rightValue: 8)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertFalse(result)
  }
  
  func testThreeLeavesTotal() {
    let treeRoot = BinaryTreeNode(1)
    treeRoot.insert(leftValue: 5)
    let rightNode = treeRoot.insert(rightValue: 9)
    rightNode.insert(leftValue: 8)
    rightNode.insert(rightValue: 5)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertTrue(result)
  }
  
  func testBothSubtreesSuperBalanced() {
    let treeRoot = BinaryTreeNode(1)
    treeRoot.insert(leftValue: 5)
    let rightNode = treeRoot.insert(rightValue: 9)
    rightNode.insert(leftValue: 8).insert(leftValue: 7)
    rightNode.insert(rightValue: 5)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertFalse(result)
  }
  
  func testBothSubtreesSuperBalancedTwo() {
    let treeRoot = BinaryTreeNode(1)
    let leftNode = treeRoot.insert(leftValue: 2)
    leftNode.insert(leftValue: 3)
    leftNode.insert(rightValue: 7).insert(rightValue: 8)
    let rightNode = treeRoot.insert(rightValue: 4)
    rightNode.insert(rightValue: 5).insert(rightValue: 6).insert(rightValue: 9)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertFalse(result)
  }
  
  func testThreeLeavesAtDifferentLevels() {
    let treeRoot = BinaryTreeNode(1)
    let leftNode = treeRoot.insert(leftValue: 2)
    let leftLeft = leftNode.insert(leftValue: 3)
    leftNode.insert(rightValue: 4)
    leftLeft.insert(leftValue: 5)
    leftLeft.insert(rightValue: 6)
    treeRoot.insert(rightValue: 7).insert(rightValue: 8).insert(rightValue: 9).insert(rightValue: 10)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertFalse(result)
  }
  
  func testOnlyOneNode() {
    let treeRoot = BinaryTreeNode(1)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertTrue(result)
  }
  
  func testLinkedListTree() {
    let treeRoot = BinaryTreeNode(1)
    treeRoot.insert(rightValue: 2).insert(rightValue: 3).insert(rightValue: 4)
    
    let result = isBalanced(treeRoot: treeRoot)
    XCTAssertTrue(result)
  }
  
  static let allTests = [
    ("testFullTree", testFullTree),
    ("testBothLeavesAtTheSameDepth", testBothLeavesAtTheSameDepth),
    ("testLeafHeightsDifferByOne", testLeafHeightsDifferByOne),
    ("testLeafHeightsDifferByTwo", testLeafHeightsDifferByTwo),
    ("testThreeLeavesTotal", testThreeLeavesTotal),
    ("testBothSubtreesSuperBalanced", testBothSubtreesSuperBalanced),
    ("testBothSubtreesSuperBalancedTwo", testBothSubtreesSuperBalancedTwo),
    ("testThreeLeavesAtDifferentLevels", testThreeLeavesAtDifferentLevels),
    ("testOnlyOneNode", testOnlyOneNode),
    ("testLinkedListTree", testLinkedListTree)
  ]
}

Tests.defaultTestSuite.run()
