import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // 점수 n 입력받음
  print('입력');
  List<String>? input = stdin.readLineSync()?.split(" ");
  if (input != null) {
    //  n(도시 크기), m(최대 치킨집 수) 입력받음
    int n = int.parse(input[0]);
    int m = int.parse(input[1]);
    List<List<int>> data = [];
    List<List<int>> house = [];
    List<List<int>> chicken = [];
    List<List<List<int>>> candidates = [];
    // 집, 치킨지 정보 입력받음
    for (int r = 0; r < n; r++) {
      List<String>? input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        List<int> array = input2.map(int.parse).toList();
        data.add(array);
        for (int c = 0; c < n; c++) {
          List<int> rc = [r, c];
          if (data[r][c] == 1) {
            house.add(rc); // 집
          } else if (data[r][c] == 2) {
            chicken.add(rc); // 치킨집
          }
        }
      }
    }
    print(' ');
    print('과정');
    for (List<int> d in data) {
      print(d);
    }
    print('house = $house');
    print('chicken = $chicken');
    // 치킨집 순열 조합
    combination(chicken, candidates, List.filled(chicken.length, false), 0, m);
    int result = 999999999999999999;
    print('---getSum()---');
    for (List<List<int>> candidate in candidates) {
      result = min(result, getSum(house, candidate));
    }
    print(' ');
    print('출력');
    print(result);
  }
}

// 백트래킹 순열 조합
void combination(List<List<int>> chicken, List<List<List<int>>> candidates,
    List<bool> visited, int start, int m) {
  if (m == 0) {
    List<List<int>> candidate = [];
    for (int v = 0; v < visited.length; v++) {
      if (visited[v]) {
        candidate.add(chicken[v]);
      }
    }
    print(candidate);
    candidates.add(candidate);
    return;
  }
  for (int i = start; i < chicken.length; i++) {
    visited[i] = true;
    combination(chicken, candidates, visited, i + 1, m - 1);
    visited[i] = false;
  }
}

// 치킨 거리의 합 계산
int getSum(List<List<int>> house, List<List<int>> candidate) {
  print('house -> $house');
  print('candidate -> $candidate');
  int result = 0;
  // 모든 집에 대하여
  int temp = 999999999999999999;
  for (List<int> h in house) {
    for (List<int> c in candidate) {
      temp = min(temp, (h[0] - c[0]).abs() + (h[1] - c[1]).abs());
      print(temp);
    }
    result += temp;
  }
  print('return = $result');
  return result;
}
/*
입력
5 2
0 2 0 1 0
1 0 1 0 0
0 0 0 0 0
2 0 0 1 1
2 2 0 1 2

과정
[0, 2, 0, 1, 0]
[1, 0, 1, 0, 0]
[0, 0, 0, 0, 0]
[2, 0, 0, 1, 1]
[2, 2, 0, 1, 2]
house = [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
chicken = [[0, 1], [3, 0], [4, 0], [4, 1], [4, 4]]
[[0, 1], [3, 0]]
[[0, 1], [4, 0]]
[[0, 1], [4, 1]]
[[0, 1], [4, 4]]
[[3, 0], [4, 0]]
[[3, 0], [4, 1]]
[[3, 0], [4, 4]]
[[4, 0], [4, 1]]
[[4, 0], [4, 4]]
[[4, 1], [4, 4]]
---getSum()---
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [3, 0]]
2
2
2
2
2
2
2
2
2
2
2
2
return = 12
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [4, 0]]
2
2
2
2
2
2
2
2
2
2
2
2
return = 12
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [4, 1]]
2
2
2
2
2
2
2
2
2
2
2
2
return = 12
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [4, 4]]
2
2
2
2
2
2
2
2
2
1
1
1
return = 10
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[3, 0], [4, 0]]
6
6
2
2
2
2
2
2
2
2
2
2
return = 16
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[3, 0], [4, 1]]
6
6
2
2
2
2
2
2
2
2
2
2
return = 16
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[3, 0], [4, 4]]
6
5
2
2
2
2
2
2
2
1
1
1
return = 13
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[4, 0], [4, 1]]
7
6
3
3
3
3
3
3
3
3
3
2
return = 20
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[4, 0], [4, 4]]
7
5
3
3
3
3
3
2
2
1
1
1
return = 15
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[4, 1], [4, 4]]
6
5
4
4
4
4
3
2
2
1
1
1
return = 17

출력
10
*/