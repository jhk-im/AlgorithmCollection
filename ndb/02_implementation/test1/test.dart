import 'dart:io';

void main(List<String> arguments) {
  String? input1 = stdin.readLineSync();
  if (input1 != null) {
    // N 입력받기
    final n = int.parse(input1);
    var x = 1;
    var y = 1;
    List<String>? input2 = stdin.readLineSync()?.split(" ");
    if (input2 != null) {
      // 경로 입력받기
      final plans = input2;
      // L, R, U, D 이동 방향
      final dx = [0, 0, -1, 1];
      final dy = [-1, 1, 0, 0];
      final moveTypes = ['L', 'R', 'U', 'D'];
      // 경로 하나씩 확인
      for (var plan in plans) {
        var nx = 0;
        var ny = 0;
        // 이동 후 좌표 구하기
        for (int i = 0; i < moveTypes.length; i++) {
          if (plan == moveTypes[i]) {
            nx = x + dx[i];
            ny = y + dy[i];
          }
        }
        // 공간을 벗어나는 경우 무시
        print('이동좌표: x = $nx, y = $ny');
        if (nx < 1 || ny < 1 || nx > n || ny > n) {
          print('공간을 벗어남');
          continue;
        }
        // 이동 수행
        x = nx;
        y = ny;
        print('이동');
      }
      print("$x $y"); // 최종 답안 출력
    }
  }
}
/*
입력
5
R R R U D D

출력
이동좌표: x = 1, y = 2
이동
이동좌표: x = 1, y = 3
이동
이동좌표: x = 1, y = 4
이동
이동좌표: x = 0, y = 4
공간을 벗어남
이동좌표: x = 2, y = 4
이동
이동좌표: x = 3, y = 4
이동
3 4
*/