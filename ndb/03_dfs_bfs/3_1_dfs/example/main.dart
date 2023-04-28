void dfs(List<List<int>> graph, int v, List<bool> visited) {
  // 현재 노드 방문 체크
  visited[v] = true;
  print('visited');
  print('$v => $visited');

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
  print(graph);
  // 각 노드 방문 정보
  var visited = List.filled(8, false);

  // dfs 호출
  dfs(graph, 1, visited); // 1 2 6 7 3 4 5
}
/*
출력
[[], [2, 3], [6, 7], [4, 5], [3, 5], [3, 4], [2], [2]]
visited
1 => [false, true, false, false, false, false, false, false]
visited
2 => [false, true, true, false, false, false, false, false]
visited
6 => [false, true, true, false, false, false, true, false]
visited
7 => [false, true, true, false, false, false, true, true]
visited
3 => [false, true, true, true, false, false, true, true]
visited
4 => [false, true, true, true, true, false, true, true]
visited
5 => [false, true, true, true, true, true, true, true]
*/