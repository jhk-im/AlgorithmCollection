import 'dart:io';

void main(List<String> arguments) {
  // 점수 n 입력받음
  List<String>? input = stdin.readLineSync()?.split("");
  if (input != null) {
    List<int> nArray = input.map(int.parse).toList();
    int left = 0;
    int right = 0;
    // 절반 씩 더하기 연산
    for (int i = 0; i < nArray.length; i++) {
      if (i < nArray.length / 2) {
        left += nArray[i];
        print('left += ${nArray[i]}');
      } else {
        right += nArray[i];
        print('right += ${nArray[i]}');
      }
    }
    // 결과 출력
    if (left == right) {
      print('LUCKY');
    } else {
      print('READY');
    }
  }
}
/*
입력
123402

과정
left += 1
left += 2
left += 3
right += 4
right += 0
right += 2

출력
LUCKY
*/