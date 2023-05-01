import 'dart:io';

import 'package:collection/collection.dart';

void main(List<String> arguments) {
  // n, m 입력받음
  List<String>? input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    final n = int.parse(input1[0]);
    final m = int.parse(input1[1]);
    List<int> array = [];
    // 볼링공 리스트 입력받음
    while (array.length != n) {
      List<String>? input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        array = input2.map(int.parse).toList();
        if (array.length != n || array.max > m) {
          print('재입력');
          array.clear();
        } else {
          print('볼링공 리스트 = $array');
        }
      }
    }
    // 결과 확인
    int result = 0;
    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        if (array[i] != array[j]) {
          result += 1;
          print('index i = ${array[i]}');
          print('index j = ${array[j]}');
          print('result = $result');
        }
      }
    }

    print(result);
  }
}
/*
입력
1 3 2 3 2

출력
볼링공 리스트 = [1, 3, 2, 3, 2]
index i = 1
index j = 3
result = 1
index i = 1
index j = 2
result = 2
index i = 1
index j = 3
result = 3
index i = 1
index j = 2
result = 4
index i = 3
index j = 2
result = 5
index i = 3
index j = 2
result = 6
index i = 2
index j = 3
result = 7
index i = 3
index j = 2
result = 8
8
*/