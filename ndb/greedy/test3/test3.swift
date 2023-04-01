import Foundation

// N, K 공백으로 구분하여 입력받음
let input1:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
var N: Int = input1[0]
let K: Int = input1[1]
var result = 0

// N이 K 이상이면 K로 계속 나누기
while N >= K {
    // N이 K로 나누어 떨어지지 않는경우 N에서 1씩 빼기
    while(N % K != 0) {
        N -= 1
        result += 1
    }
    N /= K
    result += 1
}

// 마지막 남은 수에 대하여 1씩 빼기
while (N > 1) {
    N -= 1
    result += 1
}


print(result) // 최종 답안 출력
