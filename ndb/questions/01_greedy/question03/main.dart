import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // s 입력받음
  List<String>? array = stdin.readLineSync()?.split("");
  if (array != null) {
    print('리스트 -> $array');
    int count1 = 0; // 1 체크
    int count2 = 0; // 0 체크
    if (array[0] == "1") {
      count1++;
    } else {
      count2++;
    }
    for (int i = 1; i < array.length - 1; i++) {
      if (array[i] != array[i + 1]) {
        if (array[i + 1] == "1") {
          count1++;
        } else {
          count2++;
        }
      }
    }
    print(min(count1, count2));
  }
}
/*
입력
0001100

출력
리스트 -> [0, 0, 0, 1, 1, 0, 0]
1
*/