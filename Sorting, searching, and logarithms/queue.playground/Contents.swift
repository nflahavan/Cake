import Foundation

class LinkedListNode<T> {
  
  var value: T
  var prev: LinkedListNode<T>?
  var next: LinkedListNode<T>?
  
  init(value: T, next: LinkedListNode<T>? = nil, prev: LinkedListNode<T>? = nil) {
    self.value = value
    self.next = next
  }
}

struct Queue<T> {
  private var start: LinkedListNode<T>?
  private var end: LinkedListNode<T>?
  
  mutating func enqueue(_ value: T) {
    let node = LinkedListNode(value: value)
    
    guard start != nil else {
      start = node
      end = node
      return
    }
    
    end?.next = node
    node.prev = end
    end = node
  }
  
  mutating func dequeue() -> T? {
    guard let start = start else { return nil }
    
    start.next?.prev = nil
    self.start = start.next
    
    
    return start.value
  }
}
