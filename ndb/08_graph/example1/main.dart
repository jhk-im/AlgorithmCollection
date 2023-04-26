import 'dart:io';

const int INF = 0x7fffffff; // 무한을 의미하는 값
int n = 0; // n(노드 개수)
int m = 0; // m(간선 개수)
late List<int> distance; // 최단 거리 테이블
late List<bool> visited; // 방문한 적이 있는지 체크하는 목적의 리스트
List<List<List<int>>> graph = []; // 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트

// 방문하지 않은 노드 중에서, 가장 최단 거리가 짧은 노드 반환
int getSmallestNode() {
  int min_value = INF;
  int index = 0;
  for (int i = 1; i < n + 1; i++) {
    if (distance[i] < min_value && !visited[i]) {
      min_value = distance[i];
      index = i;
    }
  }
  return index;
}

// 다익스트라 알고리즘
void dijkstra(int start) {
  // 시작 노드 초기화
  distance[start] = 0;
  visited[start] = true;
  for (List<int> j in graph[start]) {
    distance[j[0]] = j[1];
  }
  // 시작 노드를 제외한 전체 n - 1개의 노드에 대한 반복
  for (int i = 0; i < n - 1; i++) {
    // 현재 최단 거리가 가장 짧은 노드를 꺼내서, 방문 처리
    int now = getSmallestNode();
    visited[now] = true;
    // 현재 노드와 연결된 다른 노드 확인
    for (List<int> j in graph[now]) {
      int cost = distance[now] + j[1];
      // 현재 노드를 거쳐서 다른 노드로 이동하는 거리가 짧은 경우
      if (cost < distance[j[0]]) {
        distance[j[0]] = cost;
      }
    }
    print(visited);
    print(distance);
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

      for (int i = 0; i < n + 1; i++) {
        List<List<int>> list1 = [];
        graph.add(list1);
      }

      visited = List.filled(n + 1, false);
      print(visited);
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
