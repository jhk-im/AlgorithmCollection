import Foundation

func solution1() {
    // N, M 공백으로 구분하여 입력받음
    let input1:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
    let N: Int = input1[0]
    //let M: Int = input1[1]

    var result: Int = 0

    // 한 줄씩 입력받아 확인
    for _ in 1...N {
        let data:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
        var minValue: Int = 10001
        
        // list min() 함수 이용
        minValue = data.min()! // 현재 줄에서 가장 작은 수 찾기
        
        result = max(result, minValue) // 가장 작은 수 에서 가장 큰 수 찾기
    }

    print("solution1() -> \(result)") // 최종 답안 출력
}

func solution2() {
    // N, M 공백으로 구분하여 입력받음
    let input1:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
    let N: Int = input1[0]
    //let M: Int = input1[1]

    var result: Int = 0

    // 한 줄씩 입력받아 확인
    for _ in 1...N {
        let data:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
        var minValue = 10001
        
        // 이중 반복문
        for a: Int in data {
            minValue = min(minValue, a) // 현재 줄에서 가장 작은 수 찾기
        }
        
        result = max(result, minValue) // 가장 작은 수 에서 가장 큰 수 찾기
    }

    print("solution2() -> \(result)") // 최종 답안 출력
}

solution1()
solution2()
