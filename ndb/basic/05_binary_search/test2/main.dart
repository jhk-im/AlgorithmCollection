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
      List<int> array = input2.map(int.parse).toList();
      print('array=$array');

      // 이진 탐색을 위한 시작점 끝점 설정
      var start = 0;
      var end = array.reduce((curr, next) => curr > next ? curr : next);
      print('end=$end');

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
        print('start=$start, mid=$mid, end=$end, total=$total');
        if (total < m) {
          print('왼쪽 탐색');
          // 떡의 양이 부족한 경우 더 자르기 (왼쪽 탐색)
          end = mid - 1;
        } else {
          print('오른쪽 탐색');
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
/*
입력
4 6
19 15 10 17

출력
array=[19, 15, 10, 17]
end=19
start=0, mid=9, end=19, total=25
오른쪽 탐색
start=10, mid=14, end=19, total=9
오른쪽 탐색
start=15, mid=17, end=19, total=2
왼쪽 탐색
start=15, mid=15, end=16, total=6
오른쪽 탐색
start=16, mid=16, end=16, total=4
왼쪽 탐색
15
*/