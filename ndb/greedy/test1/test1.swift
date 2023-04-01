import Foundation

let input1:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
//print(type(of: input1))
//print(input1)
let N: Int = input1[0]
var M: Int = input1[1]
let K: Int = input1[2]

var input2: [Int]  = readLine()!.split(separator: " ").map { Int(String($0))! }
input2.sort()
//print(type(of: input2))
//print(input2)

let first: Int = input2[N - 1]
//print(first)
let second: Int = input2[N - 2]
//print(second)

var result: Int = 0

while true {
    for _ in 1...K {
        if M == 0 {
            break
        }
        result += first
        M -= 1
    }
    if M == 0 {
        break
    }
    result += second
    M -= 1
}

print(result)
