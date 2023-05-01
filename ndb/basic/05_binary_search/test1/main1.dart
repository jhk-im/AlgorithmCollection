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
      // 이진 탐색을 위한 사전 정렬
      nArray.sort();

      // m개의 견적서 정수 입력
      var input3 = stdin.readLineSync();
      if (input3 != null) {
        var m = int.parse(input3);

        // 견적서 전체 부품 번호 공백 구분하여 입력
        var input4 = stdin.readLineSync()?.split(' ');
        if (input4 != null) {
          List<int> mArray = input4.map(int.parse).toList();
          // 이진 탐색을 위한 사전 정렬
          mArray.sort();

          print('nArray => $nArray');
          print('mArray => $mArray');

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
    print(
        'start=${array[start]}, mid=${array[mid.toInt()]}, end=${array[end]}');
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
/*
입력
5
8 3 7 9 2
3
5 7 9

출력
nArray => [2, 3, 7, 8, 9]
mArray => [5, 7, 9]
start=2, mid=7, end=9
start=2, mid=2, end=3
start=3, mid=3, end=3
no 
start=2, mid=7, end=9
yes 
start=2, mid=7, end=9
start=8, mid=8, end=9
start=9, mid=9, end=9
yes 
*/
