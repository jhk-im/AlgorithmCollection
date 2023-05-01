import Foundation

// 나이트의 위치 입력받기
let input = Array(readLine()!)
let row = Int(String(input[1]))
let columnDictionary = ["a": 1, "b" : 2, "c" : 3, "d" : 4, "e" : 5, "f" : 6, "g" : 7, "h" : 8]
let column = columnDictionary[String(input[0])]

// 나이트가 이동할 수 있는 8가지 방향 정의
let steps = [
    (-2, -1),
    (-1, -2),
    (-2, 1),
    (-1, 2),
    (2, -1),
    (1, -2),
    (2, 1),
    (1, 2)
]

// 8가지 방향에 대하여 각 위치로 이동이 가능한지 확인
var result = 0
for step in steps {
    // 이동하고자 하는 위치 확인
    let nextRow = row! + step.0
    let nextColumn = column! + step.1
    
    // 해당 위치로 이동이 가능하다면 카운트 증가
    if nextRow >= 1 && nextRow <= 8 && nextColumn >= 1 && nextColumn <= 8 {
        result += 1
    }
}

print(result) // 최종 답안 출력
