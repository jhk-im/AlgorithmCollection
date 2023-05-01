import 'dart:io';
import 'dart:math';
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
  // n(노드 개수), m(간선 개수), start(시작 노드) 공백 구분하여 입력 받기
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);
    int start = int.parse(input1[2]);

    // 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트
    for (int i = 0; i < n + 1; i++) {
      List<List<int>> list1 = [];
      graph.add(list1);
    }

    // 최단 거리 테이블 무한으로 초기화
    distance = List.filled(n + 1, INF);

    // 모든 간선 정보 입력받기
    for (int i = 0; i < m; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        // x 노드에서 y 노드로 가는 비용 = z
        int x = int.parse(input[0]);
        int y = int.parse(input[1]);
        int z = int.parse(input[2]);
        graph[x].add([y, z]);
        print(graph);
      }
    }

    print("dijkstra");
    dijkstra(start);

    // 도달할 수 있는 노드의 개수
    int count = 0;
    // 도달 가능한 노드 중 가장 멀리 있는 노드와의 최단 거리
    int maxDistance = 0;
    for (int d in distance) {
      // 도달 가능한 노드
      if (d != INF) {
        count += 1;
        maxDistance = max(maxDistance, d);
      }
    }

    // 시작 노드 제외하기 위해 count -1
    print("${count - 1}, $maxDistance");
  }
}

/*
입력
3 2 1
1 2 4
1 3 2

출력
2 4
*/