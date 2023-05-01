fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // N 입력받기
        val n = rn.toInt()
        var count = 0

        for (i in 0..n) {
            for (j in 0..59) {
                for (k in 0..59) {
                    val three = "$i$j$k"
                    // 매 시각 안에 3이 포함되어 있는 경우 카운트 증가
                    if (three.contains('3')) {
                        count += 1
                    }
                }
            }
        }

        println(count) // 최종 답안 출력
    }
}
