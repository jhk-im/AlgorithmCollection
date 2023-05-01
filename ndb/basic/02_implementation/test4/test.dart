import 'dart:io';

void main(List<String> arguments) {
  List<String>? input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    // n, m을 공백으로 구분하여 입력받음
    final n = int.parse(input1[0]);
    final m = int.parse(input1[1]);

    // 방문한 위치를 저장하기 위한 맵 생성후 초기화
    var d = <List<int>>[];
    for (int i = 0; i < n; i++) {
      var jArr = <int>[];
      for (int j = 0; j < m; j++) {
        jArr.add(0);
      }
      d.add(jArr);
    }

    // 현재 캐릭터의 x,y,direction 입력받음
    List<String>? input2 = stdin.readLineSync()?.split(" ");
    if (input2 != null) {
      var x = int.parse(input2[0]);
      var y = int.parse(input2[1]);
      var direction = int.parse(input2[2]);

      // 현재 좌표 방문처리
      d[x][y] = 1;

      // 전체 맵 정보 입력받음
      var array = <List<int>>[];
      for (int i = 0; i < n; i++) {
        List<String>? input3 = stdin.readLineSync()?.split(" ");
        if (input3 != null) {
          var inputArr = <int>[];
          for (var input in input3) {
            inputArr.add(int.parse(input));
          }
          array.add(inputArr);
        }
      }

      // 북, 동, 남, 서 방향 정의
      final dx = [-1, 0, 1, 0];
      final dy = [0, 1, 0, -1];

      void turnLeft() {
        direction -= 1;
        if (direction == -1) {
          direction = 3;
        }
      }

      // 시뮬레이션 시작
      var count = 1;
      var turnTime = 0;
      while (true) {
        // 왼쪽으로 회전
        turnLeft();
        var nx = x + dx[direction];
        var ny = y + dy[direction];

        // 회전한 이후 정면에 가보지 않은 칸이 존재하는 경우 이동
        if (d[nx][ny] == 0 && array[nx][ny] == 0) {
          d[nx][ny] = 1;
          x = nx;
          y = ny;
          count += 1;
          turnTime = 0;
          continue;
        } else {
          turnTime += 1;
        }

        // 4방향 모두 갈 수 없는 경우
        if (turnTime == 4) {
          nx = x - dx[direction];
          ny = y - dy[direction];
          // 뒤로 갈 수 있다면 이동
          if (array[nx][ny] == 0) {
            x = nx;
            y = ny;
          } else {
            // 뒤가 바다로 막혀있는 경우
            break;
          }
          turnTime = 0;
        }
      }

      print(count); // 최종 답안 출력
    }
  }
}
