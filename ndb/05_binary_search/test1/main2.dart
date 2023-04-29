import 'dart:io';

void main(List<String> arguments) {
  // n개의 부품 정수 입력
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    var n = int.parse(input1);

    // 가게에 있는 전체 부품 번호 공백 구분하여 입력
    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      List<int> nArray = input2.map(int.parse).toList();
      var max = nArray.reduce((curr, next) => curr > next ? curr : next) + 1;
      var array = List.filled(max, 0);

      // 계수 정렬 활용
      for (int i in nArray) {
        array[i] = 1;
      }

      // m개의 견적서 정수 입력
      var input3 = stdin.readLineSync();
      if (input3 != null) {
        var m = int.parse(input3);

        // 견적서 전체 부품 번호 공백 구분하여 입력
        var input4 = stdin.readLineSync()?.split(' ');
        if (input4 != null) {
          List<int> mArray = input4.map(int.parse).toList();

          print('nArray => $nArray');
          print('mArray => $mArray');
          for (int target in mArray) {
            print('target=$target => $array');
            if (array[target] == 1) {
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
nArray => [8, 3, 7, 9, 2]
mArray => [5, 7, 9]
target=5 => [0, 0, 1, 1, 0, 0, 0, 1, 1, 1]
no 
target=7 => [0, 0, 1, 1, 0, 0, 0, 1, 1, 1]
yes 
target=9 => [0, 0, 1, 1, 0, 0, 0, 1, 1, 1]
yes 
*/