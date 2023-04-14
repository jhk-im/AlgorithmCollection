import 'dart:collection';

void bfs(List<List<int>> graph, List<bool> visited) {
  final queue = Queue<int>();
  queue.addFirst(1);

  // 현재 노드 방문 체크
  visited[1] = true;

  // 큐가 빌 때까지 반복
  while (!queue.isEmpty) {
    // 큐에서 원소를 출력
    int v = queue.removeLast();
    print('$v ');

    // 해당 원소와 연결되고 아직 방문히자 않은 원소들 큐에 삽입
    for (int i in graph[v]) {
      if (!visited[i]) {
        queue.addFirst(i);
        visited[i] = true;
      }
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

  // bfs 호출
  bfs(graph, visited); // 1 2 3 6 7 4 5
}
