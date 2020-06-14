import Foundation

#if os(Linux)
srandom(UInt32(time(nil)))
#endif

func getRandom(floor: Int, ceiling: Int) -> Int {
    #if os(Linux)
    return floor + random() % (ceiling - floor + 1)
    #else
    return floor + Int(arc4random_uniform(UInt32(ceiling - floor) + 1))
    #endif
}

func shuffle(array: inout [Int]) {


  for i in 0..<array.count {
     
    let temp = array[i]
    let randIndex = getRandom(floor: i, ceiling: array.count - 1)
    array[i] = array[randIndex]
    array[randIndex] = temp
      
  }

}

var sampleArray: [Int] = [1,2,3,4,5,6,7,8,9]
print("Sample array:")
print(sampleArray)

print("Shuffling sample array...")
shuffle(array: &sampleArray)
print(sampleArray)
