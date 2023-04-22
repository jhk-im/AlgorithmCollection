import 'dart:io';
import 'dart:math';

const int INF = 0x7fffffff; // 무한을 의미하는 값
int n = 0; // n(노드 개수)
int m = 0; // m(간선 개수)
List<List<int>> graph = [];

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);

    // 2차원 리스트(그래프 표현) 생성
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
        // a번 노드에서 b번 노드로 가는 비용이 c
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        int c = int.parse(input[2]);
        graph[a][b] = c;
      }
    }

    // 점화식에 따라 플로이드 위셜 알고리즘 수행
    for (int k = 1; k < n + 1; k++) {
      for (int a = 1; a < n + 1; a++) {
        for (int b = 1; b < n + 1; b++) {
          graph[a][b] = min(graph[a][b], graph[a][k] + graph[k][b]);
        }
      }
    }

    // 수행 결과 출력
    for (int a = 0; a < n + 1; a++) {
      print(graph[a]);
    }
  }
}

/*
입력
4 7
1 2 4
1 4 6
2 1 3
2 3 7
3 1 5
3 4 4
4 3 2

출력
[0, 0, 0, 0, 0]
[0, 0, 4, 8, 6]
[0, 3, 0, 7, 9]
[0, 5, 9, 0, 4]
[0, 7, 11, 2, 0]
*/
