import 'dart:io';

void main(List<String> arguments) {
  var input1 = stdin.readLineSync()?.split(' ');
  if (input1 != null) {
    // n, target 입력 받기
    var n = int.parse(input1[0]);
    var target = int.parse(input1[1]);

    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      List<int> array = input2.map(int.parse).toList();

      var result = binarySearch(array, target, 0, n - 1);
      if (result == null) {
        print("원소가 존재하지 않음");
      } else {
        print(result + 1);
      }
    }
  }
}

// 재귀함수 활용한 이진 탐색
int? binarySearch(List<int> array, int target, int start, int end) {
  if (start > end) {
    return null;
  }
  var mid = (start + end) / 2;
  print('start=${array[start]}, mid=${array[mid.toInt()]}, end=${array[end]}');
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

// 반복문 활용한 이진 탐색
int? binarySearchWithWhile(List<int> array, int target, int start, int end) {
  while (start <= end) {
    var mid = (start + end) ~/ 2;
    if (array[mid] == target) {
      // 중간점 인덱스가 찾는 원소인 경우 반환
      return mid;
    } else if (array[mid] > target) {
      // 중간점 보다 찾는 원소가 작은 경우 왼쪽 확인
      end = mid - 1;
    } else {
      // 중간점 보다 찾는 원소가 큰 경우 오른쪽 확인
      start = mid + 1;
    }
  }
  return null;
}
/*
입력
10 4
0 2 4 6 8 10 12 14 16 18

출력
start=0, mid=8, end=18
start=0, mid=2, end=6
start=4, mid=4, end=6
3
*/

