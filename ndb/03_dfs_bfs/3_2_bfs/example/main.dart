import 'dart:collection';

void bfs(List<List<int>> graph, List<bool> visited) {
  final queue = Queue<int>();
  queue.addFirst(1);

  // 현재 노드 방문 체크
  visited[1] = true;

  // 큐가 빌 때까지 반복
  while (queue.isNotEmpty) {
    // 큐에서 원소를 출력
    int v = queue.removeLast();
    print('$v => $visited');
    print('pop => $v');

    // 해당 원소와 연결되고 아직 방문히자 않은 원소들 큐에 삽입
    for (int i in graph[v]) {
      if (!visited[i]) {
        queue.addFirst(i);
        print('push => $i');
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
  print(graph);
  // 각 노드 방문 정보
  var visited = List.filled(8, false);
  // bfs 호출
  bfs(graph, visited); // 1 2 3 6 7 4 5
}
/*
[[], [2, 3], [6, 7], [4, 5], [3, 5], [3, 4], [2], [2]]
1 => [false, true, false, false, false, false, false, false]
pop => 1
push => 2
push => 3
2 => [false, true, true, true, false, false, false, false]
pop => 2
push => 6
push => 7
3 => [false, true, true, true, false, false, true, true]
pop => 3
push => 4
push => 5
6 => [false, true, true, true, true, true, true, true]
pop => 6
7 => [false, true, true, true, true, true, true, true]
pop => 7
4 => [false, true, true, true, true, true, true, true]
pop => 4
5 => [false, true, true, true, true, true, true, true]
pop => 5
*/