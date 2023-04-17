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
      // 이진 탐색을 위한 사전 정렬
      nArray.sort();

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
          // 이진 탐색을 위한 사전 정렬
          mArray.sort();

          for (int target in mArray) {
            var result = binarySearch(nArray, target, 0, n - 1);
            if (result == null) {
              print("no ");
            } else {
              print("yes ");
            }
          }
        }
      }
    }
  }
}

// 반복문 이진 탐색
int? binarySearch(List<int> array, int target, int start, int end) {
  while (start <= end) {
    var mid = (start + end) ~/ 2;
    if (array[mid] == target) {
      // 찾은 경우 중간점 인덱스 반환
      return mid;
    } else if (array[mid] > target) {
      // 중간점 값보다 target이 작으면 왼쪽 확인
      end = mid - 1;
    } else {
      // 중간점 값보다 target이 크면 오른쪽 확인
      start = mid + 1;
    }
  }
  return null;
}
