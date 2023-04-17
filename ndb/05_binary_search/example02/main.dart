import 'dart:io';

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(' ');
  if (input1 != null) {
    // n, target 입력 받기
    var n = int.parse(input1[0]);
    var target = int.parse(input1[1]);

    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      var intArray = <int>[];
      for (String s in input2) {
        intArray.add(int.parse(s));
      }

      var result = binarySearch(intArray, target, 0, n + 1);
      if (result == null) {
        print("원소가 존재하지 않음");
      } else {
        print(result + 1);
      }
    }
  }
}

int? binarySearch(List<int> array, int target, int start, int end) {
  if (start > end) {
    return null;
  }
  var mid = (start + end) / 2;
  if (array[mid.toInt()] == target) {
    // 중간점 인덱스가 찾는 원소인 경우 반환
    return mid.toInt();
  } else if (array[mid.toInt()] > target) {
    // 중간점 보다 찾는 원소가 작은 경우 왼쪽 확인
    return binarySearch(array, target, start, mid.toInt() - 1);
  } else {
    // 중간점 보다 찾는 원소가 큰 경우 오른쪽 확인
    return binarySearch(array, target, mid.toInt() + 1, end);
  }
}
