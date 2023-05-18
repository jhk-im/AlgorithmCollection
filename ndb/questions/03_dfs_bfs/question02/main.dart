import 'dart:io';
import 'dart:math';

// 4가지 이동 방향에 대한 리스트
List<int> dx = [-1, 0, 1, 0];
List<int> dy = [0, 1, 0, -1];
int n = 0;
int m = 0;
int result = 0;
List<List<int>> defaultData = []; // 초기화용 맵
List<List<int>> updateData = []; // 업데이트용 맵

void main(List<String> arguments) {
  print('입력');
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, m 공백 구분 입력 받기
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);
    List<List<int>> empties = []; // 빈칸 리스트
    // 지도의 정보 입력받기
    for (int i = 0; i < n; i++) {
      var input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        updateData.add(input2.map(int.parse).toList());
        defaultData.add(input2.map(int.parse).toList());
        for (int j = 0; j < m; j++) {
          if (updateData[i][j] == 0) {
            List<int> xy = [i, j];
            empties.add(xy);
          }
        }
      }
    }
    print(' ');
    print('과정');
    print('---빈칸 조합 리스트 생성');
    List<List<List<int>>> candidates = [];
    combination(empties, candidates, List.filled(empties.length, false), 0, 3);
    for (List<List<int>> candidate in candidates) {
      print(' ');
      print('---벽추가---');
      resetMap();
      for (List<int> can in candidate) {
        int x = can[0];
        int y = can[1];
        updateData[x][y] = 1;
      }
      print('빈칸조합 = $candidate');
      print('default data = $defaultData');
      print('update data = $updateData');
      checkVirus();
    }
    print(' ');
    print('출력');
    print(result);
  }
}

// 백트래킹 조합
void combination(List<List<int>> empties, List<List<List<int>>> candidates,
    List<bool> visited, int start, int m) {
  if (m == 0) {
    List<List<int>> candidate = [];
    for (int v = 0; v < visited.length; v++) {
      if (visited[v]) {
        candidate.add(empties[v]);
      }
    }
    print(candidate);
    candidates.add(candidate);
    return;
  }
  for (int i = start; i < empties.length; i++) {
    visited[i] = true;
    combination(empties, candidates, visited, i + 1, m - 1);
    visited[i] = false;
  }
}

// 맵 초기화 함수
void resetMap() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      updateData[i][j] = defaultData[i][j];
    }
  }
}

// 깊이 우선 탐색(DFS)을 활용하여 바이러스가 사방에 퍼지도록 하는 함수
void checkVirus() {
  // 바이러스 전파 진행
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      if (updateData[i][j] == 2) {
        for (int v = 0; v < 4; v++) {
          int nx = i + dx[v];
          int ny = j + dy[v];
          // 상, 하, 좌, 우 중에서 바이러스가 퍼질 수 있는 경우
          if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
            if (updateData[nx][ny] == 0) {
              updateData[nx][ny] = 2;
            }
          }
        }
      }
    }
  }
  print('checkVirus() = $updateData');
  print('getScore() = ${getScore()}');
  // 안전영역 최댓값 계산
  result = max(result, getScore());
}

// 벽을 설치한 맵의 안전영역 크기 계산
int getScore() {
  int score = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      if (updateData[i][j] == 0) {
        score += 1;
      }
    }
  }
  return score;
}
/*
입력
3 3
1 0 1
2 0 0
0 0 1
 
과정
---빈칸 조합 리스트 생성
[[0, 1], [1, 1], [1, 2]]
[[0, 1], [1, 1], [2, 0]]
[[0, 1], [1, 1], [2, 1]]
[[0, 1], [1, 2], [2, 0]]
[[0, 1], [1, 2], [2, 1]]
[[0, 1], [2, 0], [2, 1]]
[[1, 1], [1, 2], [2, 0]]
[[1, 1], [1, 2], [2, 1]]
[[1, 1], [2, 0], [2, 1]]
[[1, 2], [2, 0], [2, 1]]
 
---벽추가---
빈칸조합 = [[0, 1], [1, 1], [1, 2]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
checkVirus() = [[1, 1, 1], [2, 1, 1], [2, 2, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[0, 1], [1, 1], [2, 0]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
checkVirus() = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore() = 2
 
---벽추가---
빈칸조합 = [[0, 1], [1, 1], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
checkVirus() = [[1, 1, 1], [2, 1, 0], [2, 1, 1]]
getScore() = 1
 
---벽추가---
빈칸조합 = [[0, 1], [1, 2], [2, 0]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
checkVirus() = [[1, 1, 1], [2, 2, 1], [1, 2, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[0, 1], [1, 2], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
checkVirus() = [[1, 1, 1], [2, 2, 1], [2, 1, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[0, 1], [2, 0], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
checkVirus() = [[1, 1, 1], [2, 2, 2], [1, 1, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[1, 1], [1, 2], [2, 0]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
checkVirus() = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore() = 2
 
---벽추가---
빈칸조합 = [[1, 1], [1, 2], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
checkVirus() = [[1, 0, 1], [2, 1, 1], [2, 1, 1]]
getScore() = 1
 
---벽추가---
빈칸조합 = [[1, 1], [2, 0], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
checkVirus() = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore() = 2
 
---벽추가---
빈칸조합 = [[1, 2], [2, 0], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
checkVirus() = [[1, 2, 1], [2, 2, 1], [1, 1, 1]]
getScore() = 0
 
출력
2
*/