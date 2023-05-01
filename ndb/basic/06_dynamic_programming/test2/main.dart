import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // 정수 n 입력
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    var n = int.parse(input1);

    // 모든 식량정보 입력
    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      var array = List.filled(n + 1, 0);
      var count = 0;
      for (String s in input2) {
        array[count] = int.parse(s);
        count++;
      }

      // 계산된 결과를 저장하기 위한 DP 테이블
      var d = List.filled(100, 0);
      d[0] = array[0];
      d[1] = max(array[0], array[1]);

      // 다나믹 프로그래밍 바텀업
      for (int i = 2; i < n + 1; i++) {
        print("---");
        print("i - > $i");
        print("d[i-1] - > ${d[i - 1]}");
        print("d[i-1]+array[i] - > ${d[i - 2] + array[i]}");
        d[i] = max(d[i - 1], d[i - 2] + array[i]);
        print("d[i] -> ${d[i]}");
      }
    }
  }
}
/*
입력
4
1 3 1 5

출력
---
i - > 2
d[i-1] - > 3
d[i-1]+array[i] - > 2
d[i] -> 3
---
i - > 3
d[i-1] - > 3
d[i-1]+array[i] - > 8
d[i] -> 8
---
i - > 4
d[i-1] - > 8
d[i-1]+array[i] - > 3
d[i] -> 8
*/