import java.util.*

fun main(args: Array<String>) {
    // 각 노드가 연결된 정보를 2차원 배열로 표현
    val graph = arrayOf(
        intArrayOf(),
        intArrayOf(2, 3),
        intArrayOf(6, 7),
        intArrayOf(4, 5),
        intArrayOf(3, 5),
        intArrayOf(4, 5),
        intArrayOf(2),
        intArrayOf(2)
    )

    // 각 노드 방문 정보
    val visited = BooleanArray(8)

    // bfs 호출
    bfs(graph, visited) // 1 2 3 6 7 4 5

}

// BFS 메서드 정의
private fun bfs(graph: Array<IntArray>, visited: BooleanArray) {
    // Queue 구현을 위한 deque 라이브러리 사용
    val queue: Deque<Int> = ArrayDeque()
    queue.addFirst(1)

    // 현재 노드 방문 체크
    visited[1] = true

    // 큐가 빌 때까지 반복
    while (!queue.isEmpty()) {
        // 큐에서 원소를 출력
        val v = queue.removeLast()
        print("$v ")

        // 해당 원소와 연결되고 아직 방문히자 않은 원소들 큐에 삽입
        for (i in graph[v]) {
            if (!visited[i]) {
                queue.addFirst(i)
                visited[i] = true
            }
        }
    }
}
