import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  const int INF = 0x7fffffff; // 무한을 의미하는 값

  // n(노드 개수), m(간선 개수) 공백 구분하여 입력 받기
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    int n = int.parse(input1[0]);
    int m = int.parse(input1[1]);

    // 2차원 리스트(그래프 표현) 생성
    List<List<int>> graph = [];
    for (int i = 0; i < n + 1; i++) {
      List<int> list = [];
      for (int j = 0; j < n + 1; j++) {
        // 첫번째 column, row = 0
        // 자기 자신에게 가는 비용 = 0
        if (i > 0 && j > 0 && i != j) {
          list.add(INF);
        } else {
          list.add(0);
        }
      }
      graph.add(list);
      print(graph[i]);
    }

    // 각 간선에 대한 정보를 입력받아 초기화
    for (int i = 0; i < m; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        // a와 b가 서로에게 가는 비용은 1
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        graph[a][b] = 1;
        graph[b][a] = 1;
      }
    }

    // 거쳐갈 노드 x, 최종 목적지 k 입력
    var input2 = stdin.readLineSync()?.split(" ");
    if (input2 != null) {
      int x = int.parse(input2[0]);
      int k = int.parse(input2[1]);

      // 점화식에 따라 플로이드 위셜 알고리즘 수행
      for (int i = 1; i < n + 1; i++) {
        for (int a = 1; a < n + 1; a++) {
          for (int b = 1; b < n + 1; b++) {
            graph[a][b] = min(graph[a][b], graph[a][i] + graph[i][b]);
          }
        }
      }

      // 수행 결과 출력
      int distance = graph[1][k] + graph[k][x];
      if (distance >= INF) {
        print("-1");
      } else {
        print(distance);
      }
    }
  }
}

/*
입력
5 7
1 2
1 3
1 4
2 4
3 4
3 5
4 5
4 5

출력
3

입력2
4 2
1 3
2 4
3 4

출력2
-1
*/