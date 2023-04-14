void dfs(List<List<int>> graph, int v, List<bool> visited) {
  // 현재 노드 방문 체크
  visited[v] = true;
  print('$v ');

  // 현재 노드의 인접 노드 재귀적 방문
  for (int i in graph[v]) {
    if (!visited[i]) {
      dfs(graph, i, visited);
    }
  }
}

void main(List<String> arguments) {
  List<List<int>> graph = [
    [],
    [2, 3],
    [6, 7],
    [4, 5],
    [3, 5],
    [3, 4],
    [2],
    [2],
  ];

  // 각 노드 방문 정보
  var visited = List.filled(8, false);

  // dfs 호출
  dfs(graph, 1, visited); // 1 2 6 7 3 4 5
}
