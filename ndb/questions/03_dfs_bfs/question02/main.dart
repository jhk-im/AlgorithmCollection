import 'dart:io';
import 'dart:math';

List<int> dx = [-1, 0, 1, 0];
List<int> dy = [0, 1, 0, -1];
int n = 0;
int m = 0;
int result = 0;
List<List<int>> data = [];
List<List<int>> temp = [];
List<List<int>> defaultData = [];

void main(List<String> arguments) {
  print('입력');
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, m 공백 구분 입력 받기
    n = int.parse(input1[0]);
    m = int.parse(input1[1]);
    // 지도의 정보 입력받기
    for (int i = 0; i < n; i++) {
      var input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        data.add(input2.map(int.parse).toList());
        defaultData.add(input2.map(int.parse).toList());
        temp.add(input2.map(int.parse).toList());
      }
    }
    print(' ');
    print('과정');
    dfs(0);
    print('출력');
    print(result);
  }
}

// 깊이 우선 탐색(DFS)을 활용하여 바이러스가 사방에 퍼지도록 하는 함수
void virus(int x, int y) {
  for (int i = 0; i < 4; i++) {
    int nx = x + dx[i];
    int ny = y + dy[i];
    // 상, 하, 좌, 우 중에서 바이러스가 퍼질 수 있는 경우
    if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
      if (temp[nx][ny] == 0) {
        // 해당 위치에 바이러스 배치, 재귀 수행
        temp[nx][ny] = 2;
        virus(nx, ny);
      }
    }
  }
}

// 벽을 설치한 맵의 안전영역 크기 계산
int getScore() {
  int score = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      if (temp[i][j] == 0) {
        score += 1;
      }
    }
  }
  return score;
}

void dfs(int count) {
  // 울타리가 3개 설치된 경우
  if (count == 3) {
    temp.clear();
    for (List<int> d in data) {
      temp.add(d.sublist(0));
    }
    // 바이러스 전파 진행
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if (temp[i][j] == 2) {
          virus(i, j);
        }
      }
    }
    print('getScore = ${getScore()}');
    // 안전영역 최댓값 계산
    result = max(result, getScore());
    return;
  }
  // 울타리 설치
  int depth = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      if (data[i][j] == 0) {
        depth++;
        data[i][j] = 1;
        count += 1;
        print(' ');
        print('---카운트 증가---');
        print('i = $i');
        print('j = $j');
        print('count = $count');
        print('depth = $depth');
        print('default data = $defaultData');
        print('update data = $data');
        dfs(count);
        data[i][j] = 0;
        count -= 1;
        print(' ');
        print('---카운트 감소---');
        print('i = $i');
        print('j = $j');
        print('count = $count');
        print('depth = $depth');
        print('default data = $defaultData');
        print('update data = $data');
      }
    }
  }
}

/*
입력
3 3
1 0 1
2 0 0
0 0 1
 
과정
---카운트 증가---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 감소---
i = 1
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 감소---
i = 1
j = 2
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 감소---
i = 2
j = 0
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 감소---
i = 0
j = 1
count = 0
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 감소---
i = 1
j = 2
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 감소---
i = 2
j = 0
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]
 
---카운트 감소---
i = 1
j = 1
count = 0
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]
 
---카운트 감소---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 감소---
i = 2
j = 0
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]
 
---카운트 감소---
i = 1
j = 2
count = 0
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]
 
---카운트 감소---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]
 
---카운트 감소---
i = 1
j = 2
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]
 
---카운트 감소---
i = 2
j = 0
count = 0
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
 
---카운트 증가---
i = 2
j = 1
count = 1
depth = 5
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]
 
---카운트 감소---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]
 
---카운트 감소---
i = 1
j = 2
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 증가---
i = 2
j = 0
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2
 
---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 증가---
i = 1
j = 2
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0
 
---카운트 감소---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]
 
---카운트 감소---
i = 2
j = 0
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]
 
---카운트 감소---
i = 2
j = 1
count = 0
depth = 5
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
 
출력
2
*/