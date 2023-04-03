import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  solution1();
  solution2();
}

void solution1() {
  List<String>? input1 = stdin.readLineSync()?.split(" ");

  if (input1 != null) {
    // N, M를 공백으로 구분하여 입력받음
    final N = int.parse(input1[0]);
    //final M = int.parse(input1[1]);

    var result = 0;

    for (int i = 0; i < N; i++) {
      List<String>? input2 = stdin.readLineSync()?.split(" ");
      final data = input2?.map(int.parse).toList();
      var minValue = 10001;

      if (data != null) {
        // 이중 반복문
        data.forEach((element) {
          minValue = min(minValue, element); // 현재 줄에서 가장 작은 수 찾기
        });

        result = max(result, minValue); // 가장 작은 수 에서 가장 큰 수 찾기
      }
    }

    print("solution1() -> $result"); // 최종 답안 출력
  }
}

void solution2() {
  List<String>? input1 = stdin.readLineSync()?.split(" ");

  if (input1 != null) {
    // N, M를 공백으로 구분하여 입력받음
    final N = int.parse(input1[0]);
    //final M = int.parse(input1[1]);

    var result = 0;

    for (int i = 0; i < N; i++) {
      List<String>? input2 = stdin.readLineSync()?.split(" ");
      final data = input2?.map(int.parse).toList();
      var minValue = 10001;

      if (data != null) {
        // list min
        // max -> data.reduce((value, element) => value < element? element: value);
        minValue =
            data.reduce((value, element) => value > element ? element : value);

        result = max(result, minValue); // 가장 작은 수 에서 가장 큰 수 찾기
      }
    }

    print("solution1() -> $result"); // 최종 답안 출력
  }
}
