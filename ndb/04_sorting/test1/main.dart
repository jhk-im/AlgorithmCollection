import 'dart:io';

void main(List<String> arguments) {
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    // n 입력 받기
    var n = int.parse(input1);

    var array = <int>[];

    // 2차원 리스트 맵 정보 입력 받기
    for (int i = 0; i < n; i++) {
      var input2 = stdin.readLineSync();
      if (input2 != null) {
        array.add(int.parse(input2));
      }
    }

    // 기본 정렬 라이브러리로 내림차순 정렬
    array.sort((a, b) => b.compareTo(a));

    for (int i in array) {
      print('$i '); // 정답 출력
    }
  }
}
