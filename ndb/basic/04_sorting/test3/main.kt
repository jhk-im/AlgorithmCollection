fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // n 입력 받기
        val input = rn.split(' ')
        val n = input[0].toInt()
        val k = input[1].toInt()

        var a = IntArray(n) // 배열 A
        readlnOrNull()?.let { rn2 ->
            // 오름차순 정렬
            a = rn2.split(" ").map { it.toInt() }.toIntArray().sortedArray()
        }

        var b = IntArray(n) // 배열 B
        readlnOrNull()?.let { rn3 ->
            // 내림차순 정렬
            b  = rn3.split(" ").map { it.toInt() }.toIntArray().sortedArrayDescending()
        }

        // 첫 번째 인덱스부터 확인하여 두 배열의 원소를 최대 K번 비교
        for (i in 0 until k) {
            // A 원소가 B의 원소보다 작은 경우
            if (a[i] < b[i]) {
                a[i] = b[i].also { b[i] = a[i] }
            } else {
                break
            }
        }

        print(a.sum()) // 배열 A의 모든 원소 합 출력
    }
}
