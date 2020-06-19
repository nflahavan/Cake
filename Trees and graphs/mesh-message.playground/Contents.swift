import Foundation

// a simple, somewhat inefficient queue implementation
struct Queue<Element> {
  private var queue: [Element] = []
  
  var count: Int {
    return queue.count
  }
  
  mutating func enqueue(_ element: Element) {
    queue.insert(element, at: 0)
  }
  
  mutating func dequeue() -> Element? {
    return queue.popLast()
  }
}

enum InvalidGraph: Error {
  case startOrEndNodeNotFound
}

func getPath(graph: [String: [String]], startNode: String, endNode: String) throws -> [String]? {
  guard graph.keys.contains(startNode), graph.keys.contains(endNode) else {
    throw InvalidGraph.startOrEndNodeNotFound
  }
  guard startNode != endNode else {
    return [startNode]
  }
  var set = Set<String>()
  var queue = Queue<[String]>()
  queue.enqueue([startNode])
  while let next = queue.dequeue() {
    guard next.last != endNode else {
      return next
    }
    guard let children = graph[next.last!] else {
      continue
    }
    set.insert(next.last!)
    for child in children where !set.contains(child) {
      var another = next
      another.append(child)
      queue.enqueue(another)
    }
  }
  return nil
}


















// tests

import XCTest

class Tests: XCTestCase {
  
  let graph = [
    "a": ["b", "c", "d"],
    "b": ["a", "d"],
    "c": ["a", "e"],
    "d": ["a", "b"],
    "e": ["c"],
    "f": ["g"],
    "g": ["f"]
  ]
  
  func testTwoHopPath1() {
    do {
      let actual = try getPath(graph: graph, startNode: "a", endNode: "e")
      let expected = ["a", "c", "e"]
      assertEqual(actual, expected)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testTwoHopPath2() {
    do {
      let actual = try getPath(graph: graph, startNode: "d", endNode: "c")
      let expected = ["d", "a", "c"]
      assertEqual(actual, expected)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testOneHopPath1() {
    do {
      let actual = try getPath(graph: graph, startNode: "a", endNode: "c")
      let expected = ["a", "c"]
      assertEqual(actual, expected)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testOneHopPath2() {
    do {
      let actual = try getPath(graph: graph, startNode: "f", endNode: "g")
      let expected = ["f", "g"]
      assertEqual(actual, expected)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testOneHopPath3() {
    do {
      let actual = try getPath(graph: graph, startNode: "g", endNode: "f")
      let expected = ["g", "f"]
      assertEqual(actual, expected)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testZeroHopPath() {
    do {
      let actual = try getPath(graph: graph, startNode: "a", endNode: "a")
      let expected = ["a"]
      assertEqual(actual, expected)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testNoPath() {
    do {
      let actual = try getPath(graph: graph, startNode: "a", endNode: "f")
      XCTAssertNil(actual)
    } catch {
      XCTFail("\(error)")
    }
  }
  
  func testStartNodeNotPresent() {
    XCTAssertThrowsError(try getPath(graph: graph, startNode: "h", endNode: "a"))
  }
  
  func testEndNodeNotPresent() {
    XCTAssertThrowsError(try getPath(graph: graph, startNode: "a", endNode: "h"))
  }
  
  static let allTests = [
    ("testTwoHopPath1", testTwoHopPath1),
    ("testTwoHopPath2", testTwoHopPath2),
    ("testOneHopPath1", testOneHopPath1),
    ("testOneHopPath2", testOneHopPath2),
    ("testOneHopPath3", testOneHopPath3),
    ("testZeroHopPath", testZeroHopPath),
    ("testNoPath", testNoPath),
    ("testStartNodeNotPresent", testStartNodeNotPresent),
    ("testEndNodeNotPresent", testEndNodeNotPresent)
  ]
}

func assertEqual(_ actual: [String]?, _ expected: [String]) {
  guard let actual = actual else {
    XCTFail("actual is nil")
    return
  }
  XCTAssertEqual(actual, expected)
}

Tests.defaultTestSuite.run()


// given answer
// I actually think my space complexity is the same as theirs?

enum ShortestPathError: String, Error, CustomStringConvertible {
    case startNodeNotInGraph = "Start node not in graph"
    case endNodeNotInGraph = "End node not in graph"

    var description: String {
        return self.rawValue
    }
}

func reconstructPath(howWeReachedNodes: [String: String],
                     startNode: String, endNode: String) -> [String]  {

    var reversedShortestPath: [String] = []

    // start from the end of the path and work backwards
    var currentNode: String! = endNode

    while currentNode != nil && currentNode.count > 0 {
        reversedShortestPath.append(currentNode)
        currentNode = howWeReachedNodes[currentNode]
    }

    // reverse our path to get the right order
    reversedShortestPath.reverse()  // flip it around, in place
    return reversedShortestPath  // no longer reversed
}

func bfsGetPath(graph: [String: [String]],
                startNode: String, endNode: String) throws -> [String]? {

    guard graph[startNode] != nil else {
        throw ShortestPathError.startNodeNotInGraph
    }

    guard graph[endNode] != nil else {
        throw ShortestPathError.endNodeNotInGraph
    }

    var nodesToVisit = Queue<String>()
    nodesToVisit.enqueue(startNode)

    // keep track of how we got to each node
    // we'll use this to reconstruct the shortest path at the end
    // we'll ALSO use this to keep track of which nodes we've
    // already visited
    var howWeReachedNodes: [String: String] = [:]
    howWeReachedNodes[startNode] = ""

    while let currentNode = nodesToVisit.dequeue() {

        // stop when we reach the end node
        if currentNode == endNode {
            return reconstructPath(howWeReachedNodes: howWeReachedNodes,
                                   startNode: startNode, endNode: endNode)
        }

        for neighbor in graph[currentNode]! {
            if howWeReachedNodes[neighbor] == nil {
                nodesToVisit.enqueue(neighbor)
                howWeReachedNodes[neighbor] = currentNode
            }
        }
    }

    // if we get here, then we never found the end node
    // so there's NO path from startNode to endNode
    return nil
}
