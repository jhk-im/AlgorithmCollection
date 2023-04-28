import 'dart:io';

var n = 0;
var m = 0;
var graph = <List<int>>[];

bool dfs(int c, int r) {
  // 주어진 범위를 벗어나는 경우 즉시 종료
  if (c <= -1 || c >= n || r <= -1 || r >= m) {
    return false;
  }

  // 현재 노드를 방문하지 않은 경우
  if (graph[c][r] == 0) {
    // 해당 노드 방문 처리
    graph[c][r] = 1;

    // 상, 하, 좌, 우 재귀 호출
    dfs(c - 1, r); // 상
    dfs(c + 1, r); // 하
    dfs(c, r - 1); // 좌
    dfs(c, r + 1); // 우

    return true;
  }

  return false;
}

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, m을 공백으로 구분하여 입력받음
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);

    // 2차원 리스트 맵 정보 입력 받기
    //var array = <List<int>>[];
    for (int i = 0; i < n; i++) {
      var input2 = stdin.readLineSync()?.split("");
      if (input2 != null) {
        var intArray = <int>[];
        for (int j = 0; j < input2.length; j++) {
          if (input2[j].isNotEmpty) {
            intArray.add(int.parse(input2[j]));
          }
        }
        graph.add(intArray);
      }
    }

    print(graph);

    // 모든 노드에 대하여 음료수 채우기
    var result = 0;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        // 현재 위치에서 dfs 수행
        if (dfs(i, j)) {
          result += 1;
          print('i=$i, j=$j ->  $graph');
        }
      }
    }

    print(result); // 정답 출력
  }
}
/*
입력
3 3
010
101
000

출력
[[0, 1, 0], [1, 0, 1], [0, 0, 0]]
i=0, j=0 ->  [[1, 1, 0], [1, 0, 1], [0, 0, 0]]
i=0, j=2 ->  [[1, 1, 1], [1, 0, 1], [0, 0, 0]]
i=1, j=1 ->  [[1, 1, 1], [1, 1, 1], [1, 1, 1]]
3
*/