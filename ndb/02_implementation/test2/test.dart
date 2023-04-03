import 'dart:io';

void main(List<String> arguments) {
  String? input1 = stdin.readLineSync();
  if (input1 != null) {
    // N 입력받기
    final n = int.parse(input1);
    var count = 0;

    for (int i = 0; i < n + 1; i++) {
      for (int j = 0; j < 60; j++) {
        for (int k = 0; k < 60; k++) {
          final three = '$i$j$k';
          // 매 시각 안에 3이 포함되어 있는 경우 카운트 증가
          if (three.contains('3')) {
            count += 1;
          }
        }
      }
    }

    print(count); // 최종 답안 출력
  }
}
