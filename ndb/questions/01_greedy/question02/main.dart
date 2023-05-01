import 'dart:io';

void main(List<String> arguments) {
  // s 입력받음
  List<String>? input = stdin.readLineSync()?.split("");
  if (input != null) {
    List<int> array = [];
    for (int i = 0; i < input.length; i++) {
      if (input[i].isNotEmpty) {
        array.add(int.parse(input[i]));
      }
    }
    print('숫자 리스트 -> $array');
    int result = 0;
    for (int i in array) {
      print('---');
      if (result <= 1 || i <= 1) {
        print('더하기');
        result += i;
      } else {
        print('곱하기');
        result *= i;
      }
      print(result);
    }
  }
}
/*
입력
02984

출력
숫자 리스트 -> [0, 2, 9, 8, 4]
---
더하기
0
---
더하기
2
---
곱하기
8
---
곱하기
64
---
곱하기
576
*/