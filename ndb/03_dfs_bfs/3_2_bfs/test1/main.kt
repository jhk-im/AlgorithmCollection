import java.util.*

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

        println(bfs(0, 0)) // 정답 출력
    }
}

var n = 0
var m = 0
var dc = intArrayOf(-1, 1, 0, 0)
var dr = intArrayOf(0, 0, -1, 1)
lateinit var graph : Array<IntArray?>

// BFS 소스코드
private fun bfs(x: Int, y: Int): Int {
    // Queue 구현을 위한 deque 라이브러리 사용
    var c = x
    var r = y
    val queue: Deque<IntArray> = ArrayDeque()
    val q = intArrayOf(c, r)
    queue.addFirst(q)

    // 큐가 빌 때까지 반복
    while (!queue.isEmpty()) {
        val que = queue.removeLast()
        c = que[0]
        r = que[1]

        // 현재 위치에서 네 방향으로 위치 확인
        for (i in 0..3) {
            val nc: Int = c + dc[i]
            val nr: Int = r + dr[i]

            // 미로 공간을 벗어난 경우 무시
            if (nc < 0 || nr < 0 || nc >= n || nr >= m) {
                continue
            }

            // 벽인 경우 무시
            if (graph[nc]!![nr] == 0) {
                continue
            }

            // 노드를 처음 방문하는 경우에만 최단거리 기록
            if (graph[nc]!![nr] == 1) {
                graph[nc]!![nr] = graph[c]!![r] + 1
                val q2 = intArrayOf(nc, nr)
                queue.addFirst(q2)

                /*for (ints in queue) {
                    println(Arrays.toString(ints))
                }
                println(Arrays.toString(graph[0]))
                println(Arrays.toString(graph[1]))
                println(Arrays.toString(graph[2]))
                println("---")*/
            }
        }
    }
    return graph[n - 1]!![m - 1]
}
