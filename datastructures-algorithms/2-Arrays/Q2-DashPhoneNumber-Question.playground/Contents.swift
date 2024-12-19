import UIKit

/*
 We are given a string S representing a phone number, which we would like to reformat. String S consists of N characters: digits, spaces, and/or dashes. It contains at least two digits.
 
 Spaces and dashes in string S can be ignored. We want to reformat the given phone number is such a way that the digits are grouped in blocks of length three, separated by single dashes. If necessary, the final block or the last two blocks can be of length two.
 
 For example:
 
 S = "00-44   48 5555 8361" should become
     "004-448-555-583-61"
 
 Assume:
 - S consists only of digits (0-9), spaces, and/or dashses (-)
 - S containts at least two digits
 
 Translate:
 
 Would like to reformat a phone number string so that:
 - every third char is a "-"
 - spaces and dashes don't matter
 - if the block ends in anything other than -xxx or -xx reformat to a block of two like xx-xx (not obvious)
 
 */
func solution(_ S : String) -> String {
    // do your work here
    var array = Array(S).filter { $0.isNumber }
    let count = array.count
    var groups: [String] = []
    
    // stride를 사용하여 3개씩 그룹화 (마지막 2~3개의 요소 제외)
    for i in stride(from: 0, to: count - (count % 3 == 1 ? 4 : 3), by: 3) {
        groups.append(String(array[i..<i+3]))
    }
    
    // 마지막 그룹 처리
    if count % 3 == 1 {
        // count가 홀수 마지막 4개를 2개씩 나눔
        let lastPart = array.suffix(4)
        groups.append(String(lastPart.prefix(2)))
        groups.append(String(lastPart.suffix(2)))
    } else {
        // count가 짝수 남은 2~3개의 요소를 한 그룹으로 추가
        groups.append(String(array.suffix(count % 3)))
    }
    
    // 그룹을 "-"로 연결
    return groups.joined(separator: "-")
}

solution("123456789")           // 123-456-789
solution("555372654")           // 555-372-654
solution("0 - 22 1985--324")    // 022-198-53-24

// Edge cases
solution("01")                          // 01
solution("012")                         // 012
solution("0123")                        // 01-23
solution("0123       444")              // 012-34-44
solution("------0123       444")        // 012-34-44
