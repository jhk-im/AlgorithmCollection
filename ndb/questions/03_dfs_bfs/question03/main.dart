import 'dart:collection';
import 'dart:io';

// 4가지 이동 방향에 대한 리스트
List<int> dx = [ -1, 0, 1, 0];
List<int> dy = [ 0, 1, 0, -1];
int n = 0;
int k = 0;
int targetS = 0;
int targetX = 0;
int targetY = 0;
int result = 0;
List<List<int>> graph = []; // 전체 보드 정보를 담을 리스트
List<List<int>> data = []; // 바이러스 정보를 담을 리스트

void main(List<String> arguments) {
  print('입력');
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, k 공백 구분 입력 받기
    n = int.parse(input1[0]);
    k = int.parse(input1[1]);
    for (int i = 0; i < n; i++) {
      // 보드 정보를 한 줄 단위로 입력
      var input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        graph.add(input2.map(int.parse).toList());
        for (int j = 0; j < n; j++) {
          if (graph[i][j] != 0) {
            // {바이러스 종류, 시간, x, y} 바이러스 정보 추가
            List<int> virus = [ graph[i][j], 0, i, j ];
            data.add(virus);
          }
        }
      }
    }
    // 낮은 번호부터 확인하도록 오름차순 정렬
    data.sort((a, b) => a[0].compareTo(b[0]));
    // Queue 구현을 위한 라이브러리 사용
    final queue = Queue<List<int>>();
    for (List<int> virus in data) {
      queue.addFirst(virus);
    }
    // s, x, y 공백 구분 입력 받기
    var input3 = stdin.readLineSync()?.split(" ");
    if (input3 != null) {
      targetS = int.parse(input3[0]);
      targetX = int.parse(input3[1]);
      targetY = int.parse(input3[2]);
    }
    print(' ');
    print('과정');
    // 너비 우선 탐색(BFS)
    while (queue.isNotEmpty) {
      print('---check virus queue');
      for (List<int> virus in queue) {
        print(virus);
      }
      List<int> virusArray = queue.removeLast();
      int virus = virusArray[0];
      int s = virusArray[1];
      int x = virusArray[2];
      int y = virusArray[3];
      // s초가 지나거나 큐가 빌 때까지 반복
      if (s == targetS) {
        break;
      }
      // 현재 바이러스 정보에서 상,하,좌,우 위치 각각 확인
      for (int i = 0; i < 4; i++) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        // 해당 위치로 이동할 수 있는 경우
        if (0 <= nx && nx < n && 0 <= ny && ny < n) {
          // 방문하지 않은 위치는 바이러스 추가
          if(graph[nx][ny] == 0) {
            graph[nx][ny] = virus;
            List<int> q = [ virus, s + 1, nx, ny ];
            queue.addFirst(q);
          }
        }
      }
      print('update virus');
      for (List<int> g in graph) {
        print(g);
      }
    }
    print(' ');
    print('출력');
    result = graph[targetX - 1][targetY - 1];
    print(result);
  }
}
/*
입력
3 3
1 0 2
0 0 0
3 0 0
2 3 2

과정
---check virus queue
[3, 0, 2, 0]
[2, 0, 0, 2]
[1, 0, 0, 0]
update virus
[1, 1, 2]
[1, 0, 0]
[3, 0, 0]
---check virus queue
[1, 1, 1, 0]
[1, 1, 0, 1]
[3, 0, 2, 0]
[2, 0, 0, 2]
update virus
[1, 1, 2]
[1, 0, 2]
[3, 0, 0]
---check virus queue
[2, 1, 1, 2]
[1, 1, 1, 0]
[1, 1, 0, 1]
[3, 0, 2, 0]
update virus
[1, 1, 2]
[1, 0, 2]
[3, 3, 0]
---check virus queue
[3, 1, 2, 1]
[2, 1, 1, 2]
[1, 1, 1, 0]
[1, 1, 0, 1]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 0]
---check virus queue
[1, 2, 1, 1]
[3, 1, 2, 1]
[2, 1, 1, 2]
[1, 1, 1, 0]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 0]
---check virus queue
[1, 2, 1, 1]
[3, 1, 2, 1]
[2, 1, 1, 2]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 2]
---check virus queue
[2, 2, 2, 2]
[1, 2, 1, 1]
[3, 1, 2, 1]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 2]
---check virus queue
[2, 2, 2, 2]
[1, 2, 1, 1]

출력
3
*/