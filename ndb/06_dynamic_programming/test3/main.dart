import 'dart:io';

void main(List<String> arguments) {
  // 정수 n 입력
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    var n = int.parse(input1);

    // 계산된 결과를 저장하기 위한 DP 테이블
    var d = List.filled(1001, 0);
    d[1] = 1;
    d[2] = 3;

    // 다나믹 프로그래밍 바텀업
    for (int i = 3; i < n + 1; i++) {
      print("---");
      print("i -> $i");
      int d1 = d[i - 1];
      int d2 = d[i - 2];
      print("d1 -> $d1");
      print("d2 -> $d2");
      d[i] = (d1 + 2 * d2) % 796796;
      print("d[i] -> ${d[i]}");
    }
  }
}
/*
입력
3

출력
---
i -> 3
d1 -> 3
d2 -> 1
d[i] -> 5
*/