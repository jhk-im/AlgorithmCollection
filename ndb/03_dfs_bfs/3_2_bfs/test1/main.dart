import 'dart:collection';
import 'dart:io';

void main(List<String> arguments) {
  // v(노드 개수), e(간선) 공백 구분하여 입력 받기
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    int v = int.parse(input1[0]);
    int e = int.parse(input1[1]);
    // 모든 노드에 대한 진입차수 0으로 초기화
    List<int> indegree = List.filled(v + 1, 0);
    // 각 노드에 연결된 간선 정보를 담기 위한 연결리스트(그래프) 초기화
    List<List<int>> graph = [];
    for (int i = 0; i < v + 1; i++) {
      graph.add([]);
    }
    // 방향 그래프의 간선 정보 입력받기
    for (int i = 0; i < e; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        // 정점 A에서 B로 이동 가능
        graph[a].add(b);
        // 진입차수 1 증가
        indegree[b] += 1;
      }
    }
    print("graph");
    print(graph);
    print("indegree");
    print(indegree);
    // 위상 정렬
    List<int> result = [];
    // Queue 구현을 위한 라이브러리 사용
    final queue = Queue<int>();
    // 처음 시작할 때 진입차수가 0인 노드 큐에삽입
    for (int i = 1; i < v + 1; i++) {
      if (indegree[i] == 0) {
        queue.addFirst(i);
      }
    }
    // 큐가 빌때까지 반복
    while (queue.isNotEmpty) {
      // 큐에서 원소 꺼내기
      int now = queue.removeLast();
      result.add(now);
      print("pop");
      print(now);
      for (int i in graph[now]) {
        // 해당 원소와 연결된 노드의 진입차수 1 빼기
        indegree[i] -= 1;
        // 진입차수가 0이 되는 노드 큐에 삽입
        if (indegree[i] == 0) {
          queue.addFirst(i);
        }
      }
    }
    // 결과 출력
    print("result");
    print(result);
  }
}

/*
입력
5 6
1 2
2 3
3 4
2 5
1 5
5 4

출력
graph
[[], [2, 5], [3, 5], [4], [], [4]]
indegree
[0, 0, 1, 1, 2, 2]
pop
1
pop
2
pop
3
pop
5
pop
4
result
[1, 2, 3, 5, 4]
*/