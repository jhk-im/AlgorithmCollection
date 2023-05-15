import 'dart:math';

void main(List<String> arguments) {
  Solution solution = Solution();
  List<int> weak = [1, 3, 4, 9, 10];
  List<int> dist = [3, 5, 7];
  print(solution.solution(12, weak, dist));
}

class Solution {
  int solution(int n, List<int> weak, List<int> dist) {
    int length = weak.length;
    // weak 길이를 2배 늘려 원형을 일자 형태로 변형
    for (int i = 0; i < length; i++) {
      weak.add(weak[i] + n);
    }
    print('입력');
    print('n = $n');
    print('weak = $weak');
    print('dist = $dist');
    // 작업자 경우의 수 순열 리스트 생성
    List<List<int>> permutations = [];
    permutation(dist, List.filled(dist.length, 0),
        List.filled(dist.length, false), permutations, 0);
    print(' ');
    print('과정');
    print('permutations = $permutations');
    // 투입할 작업자 수의 최솟값을 찾아야 하므로 dist.length + 1로 하여 초기화
    int answer = dist.length + 1;
    // 0부터 length - 1 까지의 위치를 각각 시작점으로 설정
    for (int start = 0; start < length; start++) {
      // 작업자 모든 경우의 수 확인 (순열)
      for (List<int> per in permutations) {
        int count = 1; // 투입할 작업자 수
        // 작업자가 점검할 수 있는 마지막 위치
        int position = weak[start] + per[count - 1];
        print('---');
        print('순열 = $per');
        print('출발 취약 지점 = ${weak[start]}');
        print('이동 거리 = ${per[count - 1]}');
        print('취약 지점 + 이동거리 = $position');
        // 시작점 부터 모든 취약점 위치 확인
        for (int index = start; index < start + length; index++) {
          // 점검할 수 있는 위치를 벗어나는 경우
          if (position < weak[index]) {
            count += 1; // 새로운 작업자 투입
            if (count > dist.length) {
              // 더 투입이 불가능 한 경우 종료
              break;
            }
            position = weak[index] + per[count - 1];
            print('취약 지점 = ${weak[index]}');
            print('이동 거리 = ${per[count - 1]}');
            print('취약 지점 + 이동거리 = $position');
          }
        }
        answer = min(answer, count); // 최솟값 계산
        print('answer = $answer');
      }
    }
    print(' ');
    print('출력');
    if (answer > dist.length) {
      return -1;
    } else {
      return answer;
    }
  }

  // 백트래킹 순열
  void permutation(List<int> arr, List<int> output, List<bool> visited,
      List<List<int>> permutations, int depth) {
    if (depth == arr.length) {
      permutations.add(output.sublist(0));
      return;
    }
    for (int i = 0; i < arr.length; i++) {
      if (!visited[i]) {
        visited[i] = true;
        output[depth] = arr[i];
        permutation(arr, output, visited, permutations, depth + 1);
        visited[i] = false;
      }
    }
  }
}
/*
입력
n = 12
weak = [1, 3, 4, 9, 10, 13, 15, 16, 21, 22]
dist = [3, 5, 7]

과정
permutations = [[3, 5, 7], [3, 7, 5], [5, 3, 7], [5, 7, 3], [7, 3, 5], [7, 5, 3]]
---
순열 = [3, 5, 7]
출발 취약 지점 = 1
이동 거리 = 3
취약 지점 + 이동거리 = 4
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동거리 = 14
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 1
이동 거리 = 3
취약 지점 + 이동거리 = 4
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 1
이동 거리 = 5
취약 지점 + 이동거리 = 6
취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동거리 = 12
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 1
이동 거리 = 5
취약 지점 + 이동거리 = 6
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 1
이동 거리 = 7
취약 지점 + 이동거리 = 8
취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동거리 = 12
answer = 2
---
순열 = [7, 5, 3]
출발 취약 지점 = 1
이동 거리 = 7
취약 지점 + 이동거리 = 8
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동거리 = 14
answer = 2
---
순열 = [3, 5, 7]
출발 취약 지점 = 3
이동 거리 = 3
취약 지점 + 이동거리 = 6
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동거리 = 14
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 3
이동 거리 = 3
취약 지점 + 이동거리 = 6
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 3
이동 거리 = 5
취약 지점 + 이동거리 = 8
취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동거리 = 12
취약 지점 = 13
이동 거리 = 7
취약 지점 + 이동거리 = 20
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 3
이동 거리 = 5
취약 지점 + 이동거리 = 8
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 3
이동 거리 = 7
취약 지점 + 이동거리 = 10
취약 지점 = 13
이동 거리 = 3
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [7, 5, 3]
출발 취약 지점 = 3
이동 거리 = 7
취약 지점 + 이동거리 = 10
취약 지점 = 13
이동 거리 = 5
취약 지점 + 이동거리 = 18
answer = 2
---
순열 = [3, 5, 7]
출발 취약 지점 = 4
이동 거리 = 3
취약 지점 + 이동거리 = 7
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동거리 = 14
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동거리 = 22
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 4
이동 거리 = 3
취약 지점 + 이동거리 = 7
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 4
이동 거리 = 5
취약 지점 + 이동거리 = 9
취약 지점 = 10
이동 거리 = 3
취약 지점 + 이동거리 = 13
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동거리 = 22
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 4
이동 거리 = 5
취약 지점 + 이동거리 = 9
취약 지점 = 10
이동 거리 = 7
취약 지점 + 이동거리 = 17
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 4
이동 거리 = 7
취약 지점 + 이동거리 = 11
취약 지점 = 13
이동 거리 = 3
취약 지점 + 이동거리 = 16
answer = 2
---
순열 = [7, 5, 3]
출발 취약 지점 = 4
이동 거리 = 7
취약 지점 + 이동거리 = 11
취약 지점 = 13
이동 거리 = 5
취약 지점 + 이동거리 = 18
answer = 2
---
순열 = [3, 5, 7]
출발 취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동거리 = 12
취약 지점 = 13
이동 거리 = 5
취약 지점 + 이동거리 = 18
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동거리 = 12
취약 지점 = 13
이동 거리 = 7
취약 지점 + 이동거리 = 20
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동거리 = 14
취약 지점 = 15
이동 거리 = 3
취약 지점 + 이동거리 = 18
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동거리 = 14
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동거리 = 22
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 1
---
순열 = [7, 5, 3]
출발 취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동거리 = 16
answer = 1
---
순열 = [3, 5, 7]
출발 취약 지점 = 10
이동 거리 = 3
취약 지점 + 이동거리 = 13
취약 지점 = 15
이동 거리 = 5
취약 지점 + 이동거리 = 20
취약 지점 = 21
이동 거리 = 7
취약 지점 + 이동거리 = 28
answer = 1
---
순열 = [3, 7, 5]
출발 취약 지점 = 10
이동 거리 = 3
취약 지점 + 이동거리 = 13
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동거리 = 22
answer = 1
---
순열 = [5, 3, 7]
출발 취약 지점 = 10
이동 거리 = 5
취약 지점 + 이동거리 = 15
취약 지점 = 16
이동 거리 = 3
취약 지점 + 이동거리 = 19
취약 지점 = 21
이동 거리 = 7
취약 지점 + 이동거리 = 28
answer = 1
---
순열 = [5, 7, 3]
출발 취약 지점 = 10
이동 거리 = 5
취약 지점 + 이동거리 = 15
취약 지점 = 16
이동 거리 = 7
취약 지점 + 이동거리 = 23
answer = 1
---
순열 = [7, 3, 5]
출발 취약 지점 = 10
이동 거리 = 7
취약 지점 + 이동거리 = 17
취약 지점 = 21
이동 거리 = 3
취약 지점 + 이동거리 = 24
answer = 1
---
순열 = [7, 5, 3]
출발 취약 지점 = 10
이동 거리 = 7
취약 지점 + 이동거리 = 17
취약 지점 = 21
이동 거리 = 5
취약 지점 + 이동거리 = 26
answer = 1

출력
1
*/