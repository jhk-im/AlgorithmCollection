import 'dart:io';

void main(List<String> arguments) {
  // n개의 부품 정수 입력
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    var n = int.parse(input1);

    // 가게에 있는 전체 부품 번호 공백 구분하여 입력
    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      // 집합 자료형 활용
      Set<int> nSet = {};
      for (String s in input2) {
        nSet.add(int.parse(s));
      }

      // m개의 견적서 정수 입력
      var input3 = stdin.readLineSync();
      if (input3 != null) {
        var m = int.parse(input3);

        // 견적서 전체 부품 번호 공백 구분하여 입력
        var input4 = stdin.readLineSync()?.split(' ');
        if (input4 != null) {
          List<int> mArray = input4.map(int.parse).toList();

          print('nSet => $nSet');
          print('mArray => $mArray');

          for (int target in mArray) {
            if (nSet.contains(target)) {
              print("yes ");
            } else {
              print("no ");
            }
          }
        }
      }
    }
  }
}
/*
입력
5
8 3 7 9 2
3
5 7 9

출력
nSet => {8, 3, 7, 9, 2}
mArray => [5, 7, 9]
no 
yes 
yes 
*/