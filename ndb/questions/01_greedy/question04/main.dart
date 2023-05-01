import 'dart:io';

void main(List<String> arguments) {
  // n 입력받음
  String? input1 = stdin.readLineSync();
  if (input1 != null) {
    final n = int.parse(input1);
    List<int> array = [];
    // 동전 리스트 입력받음
    while (array.length != n) {
      List<String>? input2 = stdin.readLineSync()?.split(" ");
      if (input2 != null) {
        array = input2.map(int.parse).toList();
        if (array.length != n) {
          print('재입력');
          array.clear();
        } else {
          array.sort();
          print('동전 리스트 오름차순 정렬 => $array');
        }
      }
    }
    // 결과확인
    int target = 1;
    for (int i in array) {
      print('i = $i');
      print('target = $target');
      print('target >= i = ${target >= i}');
      if (target >= i) {
        target = target + i;
      }
      print('target + i = $target');
    }

    print(target);
  }
}
/*
입력
5
3 1 1 2 9

출력
동전 리스트 오름차순 정렬 => [1, 1, 2, 3, 9]
i = 1
target = 1
target >= i = true
target + i = 2
i = 1
target = 2
target >= i = true
target + i = 3
i = 2
target = 3
target >= i = true
target + i = 5
i = 3
target = 5
target >= i = true
target + i = 8
i = 9
target = 8
target >= i = false
target + i = 8
8
*/