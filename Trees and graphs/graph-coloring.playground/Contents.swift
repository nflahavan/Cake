import Foundation

let oneTwoThreeSet = Set(arrayLiteral: 1,2,3)
let threeFourFiveSet = Set(arrayLiteral: 3,4,5)
let sixSet = Set(arrayLiteral: 6)

oneTwoThreeSet.isDisjoint(with: threeFourFiveSet)
oneTwoThreeSet.isDisjoint(with: sixSet)
