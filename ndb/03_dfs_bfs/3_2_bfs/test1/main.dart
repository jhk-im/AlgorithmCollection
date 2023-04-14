import 'dart:collection';
import 'dart:io';

var n = 0;
var m = 0;
var graph = <List<int>>[];

// 상하좌우 정의
var dc = [-1, 1, 0, 0];
var dr = [0, 0, -1, 1];

int bfs(int c, int r) {
  // Queue 구현을 위한 라이브러리 사용
  final queue = Queue<List<int>>();
  var q = [c, r];
  queue.addFirst(q);

  // 큐가 빌 때까지 반복
  while (!queue.isEmpty) {
    var que = queue.removeLast();
    c = que[0];
    r = que[1];

    // 현재 위치에서 네 방향으로 위치 확인
    for (int i = 0; i < 4; i++) {
      int nc = c + dc[i];
      int nr = r + dr[i];

      // 미로 공간을 벗어난 경우 무시
      if (nc < 0 || nr < 0 || nc >= n || nr >= m) {
        continue;
      }

      // 벽인 경우 무시
      if (graph[nc][nr] == 0) {
        continue;
      }

      // 노드를 처음 방문하는 경우에만 최단거리 기록
      if (graph[nc][nr] == 1) {
        graph[nc][nr] = graph[c][r] + 1;
        var q2 = [nc, nr];
        queue.addFirst(q2);

//                    for (int[] ints : queue) {
//                        System.out.println(Arrays.toString(ints));
//                    }
//                    System.out.println(Arrays.toString(graph[0]));
//                    System.out.println(Arrays.toString(graph[1]));
//                    System.out.println(Arrays.toString(graph[2]));
//                    System.out.println("---");
      }
    }
  }

  return graph[n - 1][m - 1];
}

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, m을 공백으로 구분하여 입력받음
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);

    // 2차원 리스트 맵 정보 입력 받기
    var array = <List<int>>[];
    for (int i = 0; i < n; i++) {
      var input2 = stdin.readLineSync()?.split("");
      if (input2 != null) {
        var intArray = <int>[];
        for (int j = 0; j < input2.length; j++) {
          if (input2[j].length > 0) {
            intArray.add(int.parse(input2[j]));
          }
        }
        array.add(intArray);
      }
    }

    graph = array;

    print(bfs(0, 0)); // 정답 출력
  }
}
