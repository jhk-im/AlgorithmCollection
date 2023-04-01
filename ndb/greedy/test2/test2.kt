import java.lang.Integer.max
import java.lang.Integer.min

fun main(args: Array<String>) {
    solution1()
    solution2()
}

fun solution1() {
    readlnOrNull()?.let { rn ->
        // N, M 를 공백으로 구분하여 입력받음
        val (n, m) = rn.split(' ')
        val N = n.toInt()
        //val M = m.toInt()

        var result = 0

        for (i in 1..N) {
            readlnOrNull()?.let { rn2 ->
                val data = rn2.split(" ").map { it.toInt() }.toIntArray()
                var minValue = 10001

                // list min() 함수 이용
                minValue = data.min() // 현재 줄에서 가장 작은 수 찾기

                result = max(result, minValue) // 가장 작은 수 에서 가장 큰 수 찾기
            }
        }

        println("solution1() -> $result") // 최종 답안 출력
    }
}

fun solution2() {
    readlnOrNull()?.let { rn ->
        // N, M 를 공백으로 구분하여 입력받음
        val (n, m) = rn.split(' ')
        val N = n.toInt()
        //val M = m.toInt()

        var result = 0

        for (i in 1..N) {
            readlnOrNull()?.let { rn2 ->
                val data = rn2.split(" ").map { it.toInt() }.toIntArray()
                var minValue = 10001

                // 이중 반복문
                for (a in data) {
                    minValue = min(minValue, a) // 현재 줄에서 가장 작은 수 찾기
                }

                result = max(result, minValue) // 가장 작은 수 에서 가장 큰 수 찾기
            }
        }

        println("solution2() -> $result") // 최종 답안 출력
    }
}
