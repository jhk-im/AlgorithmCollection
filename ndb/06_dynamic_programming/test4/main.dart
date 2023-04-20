import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // n, m 공백 구분하여 입력 받기
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    var n = int.parse(input1[0]);
    var m = int.parse(input1[1]);

    // n개의 화폐 단위 정보 입력받기
    var array = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      var input = stdin.readLineSync();
      if (input != null) {
        array[i] = int.parse(input);
      }
    }

    // 계산된 결과를 저장하기 위한 DP 테이블
    var d = List.filled(m + 1, 10001);
    d[0] = 0;

    // 다나믹 프로그래밍 바텀업
    for (int i = 0; i < n; i++) {
      for (int j = array[i]; j < m + 1; j++) {
        if (d[j - array[i]] != 10001) {
          // (i - k) 방법 존재
          d[j] = min(d[j], d[j - array[i]] + 1);
          print(d);
        }
      }
    }

    // 최종 결과 출력
    if (d[m] == 10001) {
      // M원을 만드는 방법 없음
      print("-1");
    } else {
      print(d[m]);
    }
  }
}
