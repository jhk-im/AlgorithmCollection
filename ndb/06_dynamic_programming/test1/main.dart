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
    print('결과=${d[x]}');
  }
}
/*
입력
26

출력
---
i2
a1
b1
---
i3
a2
c1
---
i4
a2
b2
---
i5
a3
d1
---
i6
a2
b2
c2
---
i7
a3
---
i8
a4
b3
---
i9
a4
c2
---
i10
a3
b2
d2
---
i11
a3
---
i12
a4
b3
c3
---
i13
a4
---
i14
a5
b4
---
i15
a5
c2
d2
---
i16
a3
b3
---
i17
a4
---
i18
a5
b3
c3
---
i19
a4
---
i20
a5
b3
d3
---
i21
a4
c4
---
i22
a5
b4
---
i23
a5
---
i24
a6
b4
c4
---
i25
a5
d2
---
i26
a3
b3
결과=3
*/