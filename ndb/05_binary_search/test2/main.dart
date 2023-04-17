import 'dart:io';

void main(List<String> arguments) {
  // 떡의 개수 n, 떡의 길이 m 입력
  var input1 = stdin.readLineSync()?.split(' ');
  if (input1 != null) {
    var n = int.parse(input1[0]);
    var m = int.parse(input1[1]);

    // 각 떡의 개별 높이 정보 입력
    var input2 = stdin.readLineSync()?.split(' ');
    if (input2 != null) {
      // 집합 자료형 활용
      var array = <int>[];
      for (String s in input2) {
        array.add(int.parse(s));
      }

      // 이진 탐색을 위한 시작점 끝점 설정
      var start = 0;
      var end = array.reduce((curr, next) => curr > next ? curr : next);

      // 이진 탐색
      var result = 0;
      while (start <= end) {
        var total = 0;
        var mid = (start + end) ~/ 2;
        for (int target in array) {
          // 잘랐을 때 떡의 양 계산
          if (target > mid) {
            total += target - mid;
          }
        }
        if (total < m) {
          // 떡의 양이 부족한 경우 더 자르기 (왼쪽 탐색)
          end = mid - 1;
        } else {
          // 떡의 양이 충분한 경우 덜 자르기 (오른쪽 탐색)
          result = mid; // 최대한 덜 잘랐을 때가 정답
          start = mid + 1;
        }
      }
      // 정답 출력
      print(result);
    }
  }
}
