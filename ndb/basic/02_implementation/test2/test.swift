import Foundation

// N 입력받기
let input1:String = readLine()!
let n: Int = Int(input1)!
var count = 0;

for i in 0...n {
    for j in 0...59 {
        for k in 0...59 {
            // 매 시각 안에 3이 포함되어 있는 경우 카운트 증가
            let three = "\(i)\(j)\(k)";
            if three.contains("3") {
                count += 1
            }
        }
    }
}

print(count) // 최종 답안 출력
