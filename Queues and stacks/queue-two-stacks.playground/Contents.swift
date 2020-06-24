class QueueTwoStacks<Element> {
  private var inStack: [Element] = []
  private var outStack: [Element] = []
  
  // push into in stack
  // pull from out stack
  // if nothing in out stack
  // put everything from in stack into out stack
  // each item goes into in stack once
  // goes into out stack once
  // goes out of out stack once
  // O(m)
  
  
  func enqueue(_ item: Element) {
    inStack.append(item)
  }
  
  func dequeue() -> Element? {
    if let last = outStack.popLast() {
      return last
    }
    
    while let inLast = inStack.popLast() {
      outStack.append(inLast)
    }
    
    return outStack.popLast()
  }
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  func testBasicQueueOperations() {
    let queue = QueueTwoStacks<Int>()
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    XCTAssertEqual(1, queue.dequeue())
    XCTAssertEqual(2, queue.dequeue())
    queue.enqueue(4)
    XCTAssertEqual(3, queue.dequeue())
    XCTAssertEqual(4, queue.dequeue())
  }
  
  func testNilWhenDequeueFromNewQueue() {
    let queue = QueueTwoStacks<Int>()
    XCTAssertNil(queue.dequeue())
  }
  
  func testNilWhenDequeueFromEmptyQueue() {
    let queue = QueueTwoStacks<Int>()
    queue.enqueue(1)
    queue.enqueue(2)
    XCTAssertEqual(1, queue.dequeue())
    XCTAssertEqual(2, queue.dequeue())
    XCTAssertNil(queue.dequeue())
  }
  
  static let allTests = [
    ("testBasicQueueOperations", testBasicQueueOperations),
    ("testNilWhenDequeueFromNewQueue", testNilWhenDequeueFromNewQueue),
    ("testNilWhenDequeueFromEmptyQueue", testNilWhenDequeueFromEmptyQueue)
  ]
}

Tests.defaultTestSuite.run()
