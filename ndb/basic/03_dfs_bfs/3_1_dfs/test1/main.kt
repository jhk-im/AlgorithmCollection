fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // n, m 공백 구분 입력 받기
        val (N, M) = rn.split(' ')
        n = N.toInt()
        m = M.toInt()

        val array = arrayOfNulls<IntArray>(n)
        // 2차원 리스트 맵 정보 입력 받기
        for (i in 0 until n) {
            readlnOrNull()?.let { rn2 ->
                val input2 = rn2.chunked(1)
                val intArray = IntArray(m) { i -> i }
                for (j in input2.indices) {
                    intArray[j] = input2[j].toInt()
                }
                array[i] = intArray
            }
        }

        graph = array

        // 모든 노드에 대하여 음료수 채우기
        var result = 0
        for (i in 0 until n) {
            for (j in 0 until m) {
                // 현재 위치에서 dfs 수행
                //println("i=$i, j=$j")
                if (dfs(i, j)) {
                    result += 1
                    //println("방문처리 -> $result")
                }
            }
        }

        println(result) // 정답 출력
    }
}

var n = 0
var m = 0
lateinit var graph : Array<IntArray?>

// DFS 로 특정한 노드를 방문한 뒤 연결된 모든 노드 방문
private fun dfs(c: Int, r: Int): Boolean {
    // 주어진 범위를 벗어나는 경우 즉시 종료
    if (c <= -1 || c >= n || r <= -1 || r >= m) {
        return false
    }

    // 현재 노드를 아직 방문하지 않은 경우
    graph[c]?.let { g ->
        if (g[r] == 0) {
            // 해당 노드 방문처리 = 1
            g[r] = 1

//            println(graph[0].contentToString())
//            println(graph[1].contentToString())
//            println(graph[2].contentToString())
//            println("---")

            // 상, 하, 좌, 우 재귀 호출
            dfs(c - 1, r) // 상
            dfs(c + 1, r) // 하
            dfs(c, r - 1) // 좌
            dfs(c, r + 1) // 우
            return true
        }
    }

    return false
}