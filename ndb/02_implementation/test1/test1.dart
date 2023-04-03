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
        if (nx < 1 || ny < 1 || nx > n || ny > n) {
          continue;
        }

        // 이동 수행
        x = nx;
        y = ny;
      }
      ;

      print("$x $y"); // 최종 답안 출력
    }
  }
}
