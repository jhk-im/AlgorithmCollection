import Foundation

// N 입력받기
let input1:String = readLine()!
let n: Int = Int(input1)!
var x = 1;
var y = 1;

// 경로 입력받기
let plans:[String] = readLine()!.split(separator: " ").map { String($0) }

// L, R, U, D 이동 방향
let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]
let moveTypes = ["L", "R", "U", "D"]

// 경로 하나씩 확인
for plan in plans {
    var nx = 0
    var ny = 0
    
    // 이동 후 좌표 구하기
    for i in moveTypes.indices {
        if (plan == moveTypes[i]) {
            nx = x + dx[i]
            ny = y + dy[i]
        }
    }
    
    // 공간을 벗어나는 경우 무시
    if nx < 1 || ny < 1 || nx > n || ny > n {
        continue
    }
    
    // 이동 수행
    x = nx
    y = ny
}

print("\(x) \(y)") // 최종 답안 출력
