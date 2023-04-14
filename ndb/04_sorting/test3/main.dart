import 'dart:io';

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(' ');
  if (input1 != null) {
    // n, k 공백 구분하여 입력 받기
    var n = int.parse(input1[0]);
    var k = int.parse(input1[1]);

    var a = <int>[]; // 배열 A
    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      for (int i = 0; i < input2.length; i++) {
        a.add(int.parse(input2[i]));
      }
    }
    a.sort(); // 배열 A 오름차순 정렬

    var b = <int>[]; // 배열 B
    var input3 = stdin.readLineSync()?.split(' ');
    if (input3 != null) {
      for (int i = 0; i < input3.length; i++) {
        b.add(int.parse(input3[i]));
      }
    }
    b.sort((a, b) => b.compareTo(a)); // 배열 B 내림차순 정렬

    // 첫 번째 인덱스부터 확인하여 두 배열의 원소를 최대 K번 비교
    for (int i = 0; i < k; i++) {
      // A 원소가 B의 원소보다 작은 경우
      if (a[i] < b[i]) {
        int temp = a[i];
        a[i] = b[i];
        b[i] = temp;
      } else {
        break;
      }
    }

    print(a.reduce((value, element) => value + element)); // 배열 A의 모든 원소 합 출력
  }
}
