fun main(args: Array<String>) {
    readlnOrNull()?.let { input ->
        // 나이트의 위치 입력받기
        val row = input[1].toString().toInt()
        val columnMap = mapOf("a" to 1, "b" to 2, "c" to 3, "d" to 4, "e" to 5, "f" to 6, "g" to 7, "h" to 8)
        val column = columnMap[input[0].toString()]

        // 나이트가 이동할 수 있는 8가지 방향 정의
        val steps = arrayOf(
            arrayOf(-2, -1),
            arrayOf(-1, -2),
            arrayOf(-2, 1),
            arrayOf(-1, 2),
            arrayOf(2, -1),
            arrayOf(1, -2),
            arrayOf(2, 1),
            arrayOf(1, 2)
        )

        // 8가지 방향에 대하여 각 위치로 이동이 가능한지 확인
        var result = 0
        for (step in steps) {
            // 이동하고자 하는 위치 확인
            val nextRow = row + step[0]
            val nextColumn = column!! + step[1]

            // 해당 위치로 이동이 가능하다면 카운트 증가
            if (nextRow in 1..8 && nextColumn in 1..8) {
                result += 1
            }
        }

        println(result) // 최종 답안 출력
    }
}
