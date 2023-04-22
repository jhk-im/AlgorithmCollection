import 'dart:io';
import 'package:collection/collection.dart';

const int INF = 0x7fffffff; // 무한을 의미하는 값
int n = 0; // n(노드 개수)
int m = 0; // m(간선 개수)
late List<int> distance; // 최단 거리 테이블
List<List<List<int>>> graph = []; // 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트

class CustomEntry {
  final int key;
  final int value;

  CustomEntry({required this.key, required this.value});
}

// 다익스트라 알고리즘 - 우선순위 큐 사용
void dijkstra(int start) {
  // 시작 노드로 가기 위한 최단 경로는 0으로 설정
  PriorityQueue<CustomEntry> priorityQueue = PriorityQueue<CustomEntry>(
      (a, b) => b.toString().compareTo(a.toString()));

  priorityQueue.add(CustomEntry(key: 0, value: start));
  // 시작 노드 초기화
  distance[start] = 0;
  while (priorityQueue.isNotEmpty) {
    print(distance);
    // 가장 최단 거리가 짤은 노드에 대한 정보 꺼내기
    CustomEntry first = priorityQueue.removeFirst();
    int dist = first.key;
    int now = first.value;

    for (CustomEntry c in priorityQueue.toList()) {
      print("(${c.key},${c.value})");
    }

    // 현재 노드가 처리된 노드이면 무시
    if (distance[now] < dist) {
      continue;
    }
    // 현재 노드와 연결된 다른 인접한 노드 확인
    for (List<int> i in graph[now]) {
      int cost = dist + i[1];
      if (cost < distance[i[0]]) {
        distance[i[0]] = cost;
        priorityQueue.add(CustomEntry(key: cost, value: i[0]));
      }
    }
  }
}

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);

    // 시작 노드 번호 입력
    var input2 = stdin.readLineSync();
    if (input2 != null) {
      int start = int.parse(input2);

      // 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트
      for (int i = 0; i < n + 1; i++) {
        List<List<int>> list1 = [];
        graph.add(list1);
      }

      // 최단 거리 테이블 무한으로 초기화
      distance = List.filled(n + 1, INF);
      distance[0] = 0;
      print(distance);

      // 모든 간선 정보 입력받기
      for (int i = 0; i < m; i++) {
        var input = stdin.readLineSync()?.split(" ");
        if (input != null) {
          int a = int.parse(input[0]);
          int b = int.parse(input[1]);
          int c = int.parse(input[2]);
          graph[a].add([b, c]);
          print(graph);
        }
      }

      print("dijkstra");
      dijkstra(start);

      // 모든 노드로 가기 위한 최단 거리 출력
      print("결과");
      for (int i = 1; i < n + 1; i++) {
        // 도달할 수 없는 경우
        if (distance[i] == INF) {
          print("INFINITY");
        } else {
          // 도달 가능한 경우 거리 출력
          print(distance[i]);
        }
      }
    }
  }
}
