fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // n 입력 받기
        val n = rn.toInt()
        val array = IntArray(n);

        // 2차원 리스트 맵 정보 입력 받기
        for (i in 0 until n) {
            readlnOrNull()?.let { rn2 ->
                val input = rn2.toInt()
                array[i] = input
            }
        }

        // 코틀린 기본 정렬 라이브러리로 내림차순 정렬 수행
        val sortedArray = array.sortedArrayDescending()

        for (i in sortedArray) {
            print("$i ")
        }
    }
}
