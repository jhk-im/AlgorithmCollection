import 'dart:io';

void main(List<String> arguments) {
  // n개의 부품 정수 입력
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    var n = int.parse(input1);

    // 가게에 있는 전체 부품 번호 공백 구분하여 입력
    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      var nArray = <int>[];
      for (String s in input2) {
        nArray.add(int.parse(s));
      }
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
          var mArray = <int>[];
          for (String s in input4) {
            mArray.add(int.parse(s));
          }

          for (int target in mArray) {
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
