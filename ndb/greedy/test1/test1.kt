fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // N, M, K를 공백으로 구분하여 입력받음
        val (n, m, k) = rn.split(' ')
        val N = n.toInt()
        //println(N)
        var M = m.toInt()
        //println(M)
        val K = k.toInt()
        //println(K)

        readlnOrNull()?.let { rn2 ->
            // N개의 수를 공백으로 구분하여 입력받음
            val input2 = rn2.split(" ").map { it.toInt() }.toIntArray()
            input2.sort() // 입력받은 수 정렬
            //for (count in input2) { println(count) }

            val first = input2[N - 1] // 가장 큰 수
            val second = input2[N - 2] // 두 번째로 큰 수

            var result = 0

            /*
            - M이 10,000 이하인 경우 아래 방식으로 문제 해결 가능
            - M의 크기가 100억 이상으로 커지는 경우 시간 초과 발생
            while (true) {
                for (i in 1..K) { // 가장 큰 수를 K번 더하기
                    if (M == 0) {
                        break
                    }
                    result += first
                    M -= 1
                }

                if (M == 0) {
                    break
                }
                result += second // 두 번째로 큰 수를 한 번 더하기
                M -= 1
            }
            */

            // 가장 큰 수가 더해지는 횟수 계산
            var count:Int = (M / (K + 1) * K)
            count += M % (K + 1)

            result += (count * first) // 가장 큰 수 더하기
            result += (M - count) * second // 두 번째로 큰 수 더하기

            println(result) // 최종 답안 출력
        }
    }
}
