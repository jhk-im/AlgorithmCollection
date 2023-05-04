import 'dart:collection';
import 'dart:io';

void main(List<String> arguments) {
  String? input = stdin.readLineSync();
  if (input != null) {
    // 보드의 크기 n 입력받음
    int n = int.parse(input);
    // 보드 생성
    List<List<int>> board = [];
    for (int i = 0; i < n + 1; i++) {
      List<int> initBoard = List.filled(n + 1, 0);
      for (int j = 0; j < n + 1; j++) {
        if (i == 0 || j == 0) {
          initBoard[j] = 9;
        }
      }
      board.add(initBoard);
    }
    // 사과의 개수 k 입력 받음
    String? input2 = stdin.readLineSync();
    if (input2 != null) {
      int k = int.parse(input2);
      // 사과의 위치 입력받음
      for (int i = 0; i < k; i++) {
        List<String>? input3 = stdin.readLineSync()?.split(" ");
        if (input3 != null) {
          List<int> appleLocation = input3.map(int.parse).toList();
          board[appleLocation[0]][appleLocation[1]] = 1;
        }
      }
      // 방향 회전 정보 개수 x 입력받음
      String? input4 = stdin.readLineSync();
      if (input4 != null) {
        int x = int.parse(input4);
        // 방향 회전 정보 입력
        HashMap<int, String> drInfo = HashMap();
        List<int> timeArray = [];
        for (int i = 0; i < x; i++) {
          List<String>? info = stdin.readLineSync()?.split(" ");
          if (info != null) {
            drInfo[int.parse(info[0])] = info[1];
            timeArray.add(int.parse(info[0]));
          }
        }
        print('---board---');
        for (List<int> b in board) {
          print(b);
        }
        print('---direction info---');
        timeArray.sort();
        print(timeArray);
        // 뱀의 방향 변경 - 동 남 서 북
        List<int> directionRow = [0, 1, 0, -1];
        List<int> directionColumn = [1, 0, -1, 0];
        // 뱀 위치
        int row = 1;
        int column = 1;
        // 뱀이 존재하면 2로 표시
        board[row][column] = 2;
        // 시작방향 오른쪽
        int direction = 0;
        // 게임시간
        int time = 0;
        // 다음에 회전 할 정보
        int nextRotationIndex = 0;
        // 뱀이 차지하고 있는 위치 좌표 (꼬리, 머리)
        Queue snakeQueue = Queue<List<int>>();
        var q = [row, column];
        snakeQueue.addFirst(q);
        while (true) {
          int nextRow = row + directionRow[direction];
          int nextColumn = column + directionColumn[direction];
          print('---');
          print('direction = $direction');
          print('nextRow = $row + ${directionRow[direction]} = $nextRow');
          print(
              'nextColumn = $row + ${directionColumn[direction]} = $nextColumn');
          if (nextRotationIndex < drInfo.length) {
            print('nextDirection = ${drInfo[timeArray[nextRotationIndex]]}');
          }
          // 맵 범위 밖이 아니거나 뱀의 몸통이 없는 위치인 경우
          if (1 <= nextRow &&
              nextRow <= n &&
              1 <= nextColumn &&
              nextColumn <= n &&
              board[nextRow][nextColumn] != 2) {
            // 사과가 없는 경우 꼬리 제거
            if (board[nextRow][nextColumn] == 0) {
              board[nextRow][nextColumn] = 2;
              List<int> s2 = [nextRow, nextColumn];
              snakeQueue.addFirst(s2);
              List<int> pop = snakeQueue.removeLast();
              board[pop[0]][pop[1]] = 0;
            }
            // 사과가 있는 경우 이동 후 꼬리 유지
            if (board[nextRow][nextColumn] == 1) {
              board[nextRow][nextColumn] = 2;
              List<int> s2 = [nextRow, nextColumn];
              snakeQueue.addFirst(s2);
            }
          } else {
            // 벽 or 뱀의 몸통과 닿은 경우
            time += 1;
            break;
          }
          // 다음 머리 위치로 이동
          row = nextRow;
          column = nextColumn;
          time += 1;
          // 회전
          if (nextRotationIndex < drInfo.length &&
              time == timeArray[nextRotationIndex]) {
            direction =
                turnDirection(direction, drInfo[timeArray[nextRotationIndex]]!);
            nextRotationIndex++;
          }
          print('time = $time');
          print('---board---');
          for (List<int> b in board) {
            print(b);
          }
        }
        // 결과 출력
        print(time);
      }
    }
  }
}

int turnDirection(int direction, String nextDirection) {
  if (nextDirection == 'L') {
    direction = (direction - 1) % 4;
  } else {
    direction = (direction + 1) % 4;
  }
  return direction;
}
/*
입력
10
8
1 4
3 2
5 5
9 2
7 6
5 1
1 9
8 8
8
3 D
5 L
8 D
12 L
16 D
20 L
25 D
30 L

과정
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---direction info---
[3, 5, 8, 12, 16, 20, 25, 30]
---
direction = 0
nextRow = 1 + 0 = 1
nextColumn = 1 + 1 = 2
nextDirection = D
time = 1
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 2, 0, 1, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 1 + 0 = 1
nextColumn = 1 + 1 = 3
nextDirection = D
time = 2
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 2, 1, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 1 + 0 = 1
nextColumn = 1 + 1 = 4
nextDirection = D
time = 3
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 2, 2, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 1
nextRow = 1 + 1 = 2
nextColumn = 1 + 0 = 4
nextDirection = L
time = 4
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 1
nextRow = 2 + 1 = 3
nextColumn = 2 + 0 = 4
nextDirection = L
time = 5
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 3 + 0 = 3
nextColumn = 3 + 1 = 5
nextDirection = D
time = 6
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 2, 2, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 3 + 0 = 3
nextColumn = 3 + 1 = 6
nextDirection = D
time = 7
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 2, 2, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 3 + 0 = 3
nextColumn = 3 + 1 = 7
nextDirection = D
time = 8
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 2, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 1
nextRow = 3 + 1 = 4
nextColumn = 3 + 0 = 7
nextDirection = L
time = 9
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 1
nextRow = 4 + 1 = 5
nextColumn = 4 + 0 = 7
nextDirection = L
time = 10
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 1
nextRow = 5 + 1 = 6
nextColumn = 5 + 0 = 7
nextDirection = L
time = 11
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 1
nextRow = 6 + 1 = 7
nextColumn = 6 + 0 = 7
nextDirection = L
time = 12
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 7 + 0 = 7
nextColumn = 7 + 1 = 8
nextDirection = D
time = 13
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 2, 2, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 7 + 0 = 7
nextColumn = 7 + 1 = 9
nextDirection = D
time = 14
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 2, 2, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 7 + 0 = 7
nextColumn = 7 + 1 = 10
nextDirection = D
time = 15
---board---
[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 1, 0, 0, 2, 2]
[9, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
[9, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
---
direction = 0
nextRow = 7 + 0 = 7
nextColumn = 7 + 1 = 11
nextDirection = D

출력
16
*/