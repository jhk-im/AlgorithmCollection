import 'dart:collection';
import 'dart:io';

void main(List<String> arguments) {
  print('입력');
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, m, k, x 공백 구분 입력 받기
    int n = int.parse(input1[0]);
    int m = int.parse(input1[1]);
    int k = int.parse(input1[2]);
    int x = int.parse(input1[3]);
    // 모든 도로 정보 입력받기
    List<List<int>> graph = [];
    for (int i = 0; i < n + 1; i++) {
      graph.add([]);
    }
    for (int i = 0; i < m; i++) {
      var input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        int a = int.parse(input2[0]);
        int b = int.parse(input2[1]);
        graph[a].add(b);
      }
    }
    print(' ');
    print('과정');
    print('graph = $graph');
    // 모든 도시에 대한 최단 거리 초기화
    List<int> distance = List.filled(n + 1, -1);
    // 출발도시 까지의 거리는 0
    distance[x] = 0;
    // 너비 우선 탐색(BFS)
    final queue = Queue<int>(); // Queue 구현을 위한 라이브러리 사용
    queue.addFirst(x);
    // 큐가 빌 때까지 반복
    while (queue.isNotEmpty) {
      var now = queue.removeLast();
      print('distance = $distance');
      print('현재 도시 = $now');
      // 현재 도시에서 이동할 수 있는 모든 도시 확인
      for (int next in graph[now]) {
        // 방문하지 않은 도시
        if (distance[next] == -1) {
          print('방문하지 않은 도시 = $next');
          // 최단 거리 갱신
          distance[next] = distance[now] + 1;
          print('방문하지 않은 도시 최단거리 갱신 = ${distance[next]}');
          queue.addFirst(next);
        }
      }
    }
    print(' ');
    print('출력');
    bool check = false;
    for (int i = 1; i < n + 1; i++) {
      if (distance[i] == k) {
        print(i);
        check = true;
      }
    }
    if (!check) {
      print(-1);
    }
  }
}
/*
입력
6 6 2 1
1 2
1 3
2 4
3 5
4 6
5 6

과정
graph = [[], [2, 3], [4], [5], [6], [6], []]
distance = [-1, 0, -1, -1, -1, -1, -1]
현재 도시 = 1
방문하지 않은 도시 = 2
방문하지 않은 도시 최단거리 갱신 = 1
방문하지 않은 도시 = 3
방문하지 않은 도시 최단거리 갱신 = 1
distance = [-1, 0, 1, 1, -1, -1, -1]
현재 도시 = 2
방문하지 않은 도시 = 4
방문하지 않은 도시 최단거리 갱신 = 2
distance = [-1, 0, 1, 1, 2, -1, -1]
현재 도시 = 3
방문하지 않은 도시 = 5
방문하지 않은 도시 최단거리 갱신 = 2
distance = [-1, 0, 1, 1, 2, 2, -1]
현재 도시 = 4
방문하지 않은 도시 = 6
방문하지 않은 도시 최단거리 갱신 = 3
distance = [-1, 0, 1, 1, 2, 2, 3]
현재 도시 = 5
distance = [-1, 0, 1, 1, 2, 2, 3]
현재 도시 = 6

출력
4
5
*/