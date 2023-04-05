fun main(args: Array<String>) {
    readlnOrNull()?.let { rn1 ->
        // n, m을 공백으로 구분하여 입력받음
        val (n, m) = rn1.split(' ').map { it.toInt() }

        // 방문한 위치를 저장하기 위한 맵 생성후 초기화
        var d : Array<Array<Int>> = arrayOf()
        for (i in 0 until n) {
            var jArr: Array<Int> = arrayOf()
            for (j in 0 until m) {
                jArr += 0
            }
            d += jArr
        }

        println(d.size)

        readlnOrNull()?.let { rn2 ->
            // 현재 캐릭터의 x,y,direction 입력받음
            var (x, y, direction) = rn2.split(' ').map { it.toInt() }

            // 현재 좌표 방문처리
            d[x][y] = 1

            // 전체 맵 정보 입력받음
            var array : Array<IntArray> = arrayOf()
            for (i in 0 until n) {
                readlnOrNull()?.let { rn3 ->
                    val inputArr = rn3.split(" ").map { it.toInt() }.toIntArray()
                    array += inputArr
                }
            }

            // 북, 동, 남, 서 방향 정의
            val dx = arrayOf(-1, 0, 1, 0)
            val dy = arrayOf(0, 1, 0 ,-1)

            fun turnLeft() {
                direction -= 1
                if (direction == -1) {
                    direction = 3
                }
            }

            // 시뮬레이션 시작
            var count = 1
            var turnTime = 0
            while (true) {
                // 왼쪽으로 회전
                turnLeft()
                var nx = x + dx[direction]
                var ny = y + dy[direction]

                // 회전한 이후 정면에 가보지 않은 칸이 존재하는 경우 이동
                if (d[nx][ny] == 0 && array[nx][ny] == 0) {
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
                if (turnTime == 4) {
                    nx = x - dx[direction]
                    ny = y - dy[direction]
                    // 뒤로 갈 수 있다면 이동
                    if (array[nx][ny] == 0) {
                        x = nx
                        y = ny
                    } else {
                        // 뒤가 바다로 막혀있는 경우
                        break
                    }
                    turnTime = 0
                }
            }

            println(count) // 최종 답안 출력
        }
    }
}
