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
    array.sort();
    print('숫자 리스트 오름차순 정렬 -> $array');
    int result = 0;
    for (int i in array) {
      print('---');
      if (result == 0 || i < 2) {
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
숫자 리스트 오름차순 정렬 -> [0, 2, 4, 8, 9]
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