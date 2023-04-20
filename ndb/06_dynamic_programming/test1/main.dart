import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // 정수 X 입력
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    var x = int.parse(input1);

    // 계산된 결과를 저장하기 위한 DP 테이블
    var d = List.filled(300001, 0);

    // 다나믹 프로그래밍 바텀업
    for (int i = 2; i < x + 1; i++) {
      print("---");
      print("i$i");
      // 현재의 수에서 1을 빼는 경우
      d[i] = d[i - 1] + 1;
      print("a${d[i]}");
      // 현재의 수가 2로 나누어 떨어지는 경우
      if (i % 2 == 0) {
        var j = i / 2;
        d[i] = min(d[i], d[j.toInt()] + 1);
        print("b${d[i]}");
      }
      // 현재의 수가 3으로 나누어 떨어지는 경우
      if (i % 3 == 0) {
        var j = i / 3;
        d[i] = min(d[i], d[j.toInt()] + 1);
        print("c${d[i]}");
      }
      // 현재의 수가 3으로 나누어 떨어지는 경우
      if (i % 5 == 0) {
        var j = i / 5;
        d[i] = min(d[i], d[j.toInt()] + 1);
        print("d${d[i]}");
      }
    }
  }
}
