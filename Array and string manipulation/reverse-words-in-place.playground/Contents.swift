func reverseWordsFirstTry(in str: inout String) {

  guard !str.isEmpty else { return }
  
  var a = 0
  var b = 0

  var y = str.count - 1
  var z = str.count - 1
  
  while b <= y {

    let bIsSpace = str[str.index(str.startIndex, offsetBy: b)] == " "
    let yIsSpace = str[str.index(str.startIndex, offsetBy: y)] == " "
    
    switch (bIsSpace, yIsSpace) {
    
    case (true, true):
    
      swapSubstrings(in: &str, firstSubstringBeginOffset: a, firstSubstringEndOffsetPlusOne: b, secondIndexBeginOffsetMinusOne: y, secondIndexEndOffset: z)

      let abCount = b - a
      let yzCount = z - y
      
      b = b + (yzCount - abCount)
      y = y + (yzCount - abCount)
      
      b += 1
      y -= 1
      
      a = b
      z = y
    
    case (true, false):
    
      y -= 1
    
    case (false, true):
    
      b += 1
    
    case (false, false):
    
      b += 1
      y -= 1
    
    }
    
  }
  
}

func swapSubstrings(
  in str: inout String,
  firstSubstringBeginOffset a: Int,
  firstSubstringEndOffsetPlusOne b: Int,
  secondIndexBeginOffsetMinusOne y: Int,
  secondIndexEndOffset z: Int) {
  
  let abRange = str.index(str.startIndex, offsetBy: a)..<str.index(str.startIndex, offsetBy: b)
  let ab = str[abRange]
  let abCount = ab.count

  let yzRange = str.index(str.startIndex, offsetBy: y + 1)...str.index(str.startIndex, offsetBy: z)
  let yz = str[yzRange]
  let yzCount = yz.count

  str.removeSubrange(abRange)

  str.insert(contentsOf: yz, at: str.index(str.startIndex, offsetBy: a))

  let tempY = y + (yzCount - abCount)
  let tempZ = z + (yzCount - abCount)
  let newYzRange = str.index(str.startIndex, offsetBy: tempY + 1)...str.index(str.startIndex, offsetBy: tempZ)

  str.removeSubrange(newYzRange)

  str.insert(contentsOf: ab, at: str.index(str.startIndex, offsetBy: tempY + 1))
  
}

var str2 = "Hello playground yo ay So does this really work"

reverseWordsFirstTry(in: &str2)

func reversePortionOf(_ str: inout String, startingWith startIndex: String.Index, endingBefore endIndex: String.Index) {
  
  guard startIndex != endIndex else { return }
  
  var a = startIndex
  var z = str.index(before: endIndex)
  
  while a < z {
    
    let aChar = str[a]
    let zChar = str[z]
    
    print("aChar: \(aChar), zChar: \(zChar)")
    str.replaceSubrange(a...a, with: String(zChar))
    str.replaceSubrange(z...z, with: String(aChar))
    
    a = str.index(after: a)
    z = str.index(before: z)
    
  }
  
}

var twoWords = "two Words"
reversePortionOf(&twoWords, startingWith: twoWords.startIndex, endingBefore: twoWords.index(twoWords.startIndex, offsetBy: 3))

func reverseWordsSecondTry(_ str: inout String) {
  
  var a = str.startIndex
  var b = str.startIndex
  
  while b < str.endIndex {
    
    let bChar = str[b]
  
    if !("a"..."z").contains(String(bChar)) {
      print("a: \(a), b: \(b)")
      reversePortionOf(&str, startingWith: a, endingBefore: b)
      
      a = str.index(after: b)
      
    }
    
    b = str.index(after: b)
    
  }
  
  reversePortionOf(&str, startingWith: a, endingBefore: b)
  reversePortionOf(&str, startingWith: str.startIndex, endingBefore: str.endIndex)
  
}

var threeWords = "?question a this is"
reverseWordsSecondTry(&threeWords)
