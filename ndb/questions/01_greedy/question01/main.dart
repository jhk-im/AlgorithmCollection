import 'dart:io';

void main(List<String> arguments) {
  // n 입력받음
  List<String>? input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    final n = int.parse(input1[0]);
    List<int> array = [];
    // 공포도 리스트 입력 받음
    while (array.length != n) {
      List<String>? input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        array = input2.map(int.parse).toList();
        if (array.length != n) {
          print('재입력');
          array.clear();
        } else {
          // 내림차순으로 정렬
          array.sort((a, b) => b.compareTo(a));
          print('공포도 리스트 내림차순 정렬 => $array');
        }
      }
    }
    // 결과확인
    int result = 0;
    int arraySize = n;
    int nextIndex = 0;
    while (nextIndex < n) {
      int limit = array[nextIndex]; // 3
      print('---');
      print('limit => $limit');
      if (limit == 0) {
        limit = 1;
      }
      if (limit <= arraySize) {
        arraySize -= limit; // 2
        nextIndex += limit; // 3
        result += 1;
      } else {
        arraySize -= 1;
        nextIndex += 1;
      }
      print('arraySize => $arraySize');
      print('nextIndex => $nextIndex');
      print('result => $result');
    }
  }
}
/*
입력
5
2 3 1 2 2

출력
공포도 리스트 내림차순 정렬 => [3, 2, 2, 2, 1]
---
limit => 3
arraySize => 2
nextIndex => 3
result => 1
---
limit => 2
arraySize => 0
nextIndex => 5
result => 2
*/