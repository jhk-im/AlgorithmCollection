import Foundation

// n, m을 공백으로 구분하여 입력받음
let input1:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
let n: Int = input1[0]
let m: Int = input1[1]

// 방문한 위치를 저장하기 위한 맵 생성후 초기화
var d = Array<[Int]>()
for _ in 0...n - 1 {
    var jArr = Array<Int>()
    for _ in 0...m - 1 {
        jArr.append(0)
    }
    d.append(jArr)
}

// 현재 캐릭터의 x,y,direction 입력받음
let input2:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
var x: Int = input2[0]
var y: Int = input2[1]
var direction: Int = input2[2]

// 현재 좌표 방문 처리
d[x][y] = 1
//print(d)

// 전체 맵 정보 입력받음
var array = Array<[Int]>()
for _ in 0...n - 1 {
    let input3:[Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
    array.append(input3)
}
//print(array)

// 북, 동, 남, 서 방향 정의
let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0 ,-1]

// 왼쪽으로 회전시키는 메서드
func turnLeft() {
    direction -= 1
    if direction == -1 {
        direction = 3
    }
}

// 시뮬레이션 시작
var count = 1
var turnTime = 0
while true {
    // 왼쪽으로 회전
    turnLeft()
    var nx = x + dx[direction]
    var ny = y + dy[direction]
    
    // 회전한 이후 정면에 가보지 않은 칸이 존재하는 경우 이동
    if d[nx][ny] == 0 && array[nx][ny] == 0 {
        d[nx][ny] = 1
        x = nx
        y = ny
        count += 1
        turnTime = 0
        continue
    } else {
        turnTime += 1
    }
    
    // 4방향 모두 갈 수 없는 경우
    if turnTime == 4 {
        nx = x - dx[direction]
        ny = y - dy[direction]
        // 뒤로 갈 수 있다면 이동
        if array[nx][ny] == 0 {
            x = nx
            y = ny
        } else {
            // 뒤가 바다로 막혀있는 경우
            break
        }
        turnTime = 0
    }
}

print(count) // 최종 답안 출력
