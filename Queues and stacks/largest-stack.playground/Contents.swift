class Stack<Item> {
  
  // initialize an empty array to hold our stack items
  var items: [Item] = []
  
  // push a new item onto the stack
  func push(_ item: Item) {
    items.append(item)
  }
  
  // remove and return the last item
  func pop() -> Item? {
    
    // if the stack is empty, return nil
    // (it would also be reasonable to throw an exception)
    if items.count == 0 {
      return nil
    }
    return items.removeLast()
  }
  
  // return the last item without removing it
  func peek() -> Item? {
    return items.last
  }
}

class MaxStack {
  
  // If we keep a list sorted
  // push will be O(log(n))
  // pop will stay the same
  // getMax will be O(1)
  
  // If we look for a max and don't keep a list
  // push will stay the same
  // pop will stay the same
  // getMax will be O(n)
  
  // we could alternatively keep track of max
  // update it on push
  // and sometimes find it again on pop
  // push will stay the same
  // sometimes pop will be O(n), sometimes it will be O(1)
  // getMax will be O(1)
  
  // What needs to be realized is that some data will never become max
  // consider a stack that takes data 1 , 3 , 2
  // we could keep track of all this data
  // but realize that we never need to keep track of 2
  // 3 is max, and if 2 were to become max, it'd have to be popped off first
  // after it gets pushed back on we can treat it like it's new
  // so we don't need to keep track of it
  // we keep track of max's in a stack
  // we need the current max, and the next max which must have been pushed on before current max
  // therefore, any new data that comes after current max is either new max, or we don't care to keep track of it
  
  let maxStack = Stack<Int>()
  let dataStack = Stack<Int>()
  
  func push(_ item: Int) {
    dataStack.push(item)
    
    guard let currMax = maxStack.peek() else {
      maxStack.push(item)
      return
    }
    
    if item >= currMax {
      maxStack.push(item)
    }
  }
  
  func pop() -> Int? {
    let popped = dataStack.pop()
    guard let currMax = maxStack.peek() else {
      return popped
    }
    
    if popped == currMax {
      _ = maxStack.pop()
    }
    
    return popped
  }
  
  func getMax() -> Int? {
    return maxStack.peek()
  }
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testMaxStack() {
    let stack = MaxStack()
    stack.push(5)
    XCTAssertEqual(5, stack.getMax())
    stack.push(4)
    stack.push(7)
    stack.push(7)
    stack.push(8)
    XCTAssertEqual(8, stack.getMax())
    XCTAssertEqual(8, stack.pop())
    XCTAssertEqual(7, stack.getMax())
    XCTAssertEqual(7, stack.pop())
    XCTAssertEqual(7, stack.getMax())
    XCTAssertEqual(7, stack.pop())
    XCTAssertEqual(5, stack.getMax())
    XCTAssertEqual(4, stack.pop())
    XCTAssertEqual(5, stack.getMax())
  }
  
  static let allTests = [
    ("testMaxStack", testMaxStack)
  ]
}

Tests.defaultTestSuite.run()
