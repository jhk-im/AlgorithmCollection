import 'dart:collection';
import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // v(노드 개수) 입력 받기
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    int v = int.parse(input1);
    // 모든 노드에 대한 진입차수 0으로 초기화
    List<int> indegree = List.filled(v + 1, 0);
    // 각 노드에 연결된 간선 정보를 담기 위한 연결리스트(그래프) 초기화
    List<List<int>> graph = [];
    for (int i = 0; i < v + 1; i++) {
      graph.add([]);
    }
    // 각 강의 시간을 0으로 초기화
    List<int> time = List.filled(v + 1, 0);
    // 방향 그래프의 간선 정보 입력받기
    for (int i = 1; i < v + 1; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        List<int> data = input.map(int.parse).toList();
        // 첫 번째 수는 시간 정보를 담고 있음
        time[i] = data[0];
        for (int j = 1; j < data.length - 1; j++) {
          indegree[i] += 1;
          graph[data[j]].add(i);
        }
      }
    }
    print("graph");
    print(graph);
    print("indegree");
    print(indegree);
    print("time");
    print(time);
    // 위상 정렬
    List<int> result = List.of(time); // 알고리즘 수행결과를 담을 리스트
    final queue = Queue<int>(); // Queue 구현을 위한 라이브러리 사용
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
      print("pop");
      print(now);
      for (int i in graph[now]) {
        result[i] = max(result[i], result[now] + time[i]);
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
5
10 -1
10 1 -1
4 1 -1
4 3 1 -1
3 3 -1

출력
graph
[[], [2, 3, 4], [], [4, 5], [], []]
indegree
[0, 0, 1, 1, 2, 1]
time
[0, 10, 10, 4, 4, 3]
pop
1
pop
2
pop
3
pop
4
pop
5
result
[0, 10, 20, 14, 18, 17]
*/