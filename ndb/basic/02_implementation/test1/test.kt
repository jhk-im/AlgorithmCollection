fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // N 입력받기
        val n = rn.toInt()
        var (x, y) = arrayOf(1, 1)

        readlnOrNull()?.let { rn2 ->
            // 경로 입력받기
            val plans = rn2.split(' ')

            // L, R, U, D 이동 방향
            val dx = arrayOf(0, 0, -1, 1)
            val dy = arrayOf(-1, 1, 0, 0)
            val moveTypes = arrayOf("L", "R", "U", "D")

            // 경로 하나씩 확인
            for (plan in plans) {
                var nx = 0
                var ny = 0
                
                // 이동 후 좌표 구하기
                for (i in moveTypes.indices) { /* indices -> 최소인덱스..최대인덱스 */
                    if (plan == moveTypes[i]) {
                        nx = x + dx[i]
                        ny = y + dy[i]
                    }
                }

                // 공간을 벗어나는 경우 무시
                if (nx < 1 || ny < 1 || nx > n || ny > n) {
                    continue
                }

                // 이동 수행
                x = nx
                y = ny
            }

            println("$x $y") // 최종 답안 출력
        }
    }
}
