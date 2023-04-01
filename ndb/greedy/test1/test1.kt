fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        val (n, m, k) = rn.split(' ')
        val N = n.toInt()
        //println(N)
        var M = m.toInt()
        //println(M)
        val K = k.toInt()
        //println(K)

        readlnOrNull()?.let { rn2 ->
            val input2 = rn2.split(" ").map { it.toInt() }.toIntArray()
            input2.sort()
            //for (count in input2) { println(count) }

            val first = input2[N - 1]
            val second = input2[N - 2]

            var result = 0

            while (true) {
                for (i in 1..K) {
                    if (M == 0) {
                        break
                    }
                    result += first
                    M -= 1
                }

                if (M == 0) {
                    break
                }
                result += second
                M -= 1
            }

            println(result)
        }
    }
}