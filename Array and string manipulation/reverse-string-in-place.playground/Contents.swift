import UIKit

var str = "Hello, playground"

func reverse(_ str: inout String) {

    guard !str.isEmpty else { return }
    
    var smallIndexInt = 0
    var bigIndexInt = str.count - 1

    while smallIndexInt < bigIndexInt {
      
        let smallIndexIndex = str.index(str.startIndex, offsetBy: smallIndexInt)
        let bigIndexIndex = str.index(str.startIndex, offsetBy: bigIndexInt)
        let smallChar = str.remove(at: smallIndexIndex)
        str.insert(smallChar, at: bigIndexIndex)
        
        let bigIndexIndexMinusOne = str.index(str.startIndex, offsetBy: bigIndexInt - 1)
        let bigChar = str.remove(at: bigIndexIndexMinusOne)
        str.insert(bigChar, at: smallIndexIndex)
        
        smallIndexInt += 1
        bigIndexInt -= 1
        
    }
    
}

print(str)
reverse(&str)
print(str)
