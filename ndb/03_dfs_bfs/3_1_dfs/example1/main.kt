fun main(args: Array<String>) {
    // 각 노드가 연결된 정보를 2차원 배열로 표현
    val graph = arrayOf(
        intArrayOf(),
        intArrayOf(2, 3),
        intArrayOf(6, 7),
        intArrayOf(4, 5),
        intArrayOf(3, 5),
        intArrayOf(3, 4),
        intArrayOf(2),
        intArrayOf(2)
    )

    // 각 노드 방문 정보
    val visited = BooleanArray(8)

    // dfs 호출
    dfs(graph, 1, visited) // 1 2 6 7 3 4 5
}

// DFS 메서드 정의
private fun dfs(graph: Array<IntArray>, v: Int, visited: BooleanArray) {
    // 현재 노드 방문 체크
    visited[v] = true
    print("$v ")

    // 현재 노드의 인접 노드 재귀적 방문
    for (i in graph[v]) {
        if (!visited[i]) {
            dfs(graph, i, visited)
        }
    }
}
