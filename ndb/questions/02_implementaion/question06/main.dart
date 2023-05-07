/// List<List<int>>
/// contains(), remove() 오동작 확인해봐야함
///
///
void main(List<String> arguments) {
  Solution solution = Solution();
  print(solution.solution(5, [
    [0, 0, 0, 1],
    [2, 0, 0, 1],
    [4, 0, 0, 1],
    [0, 1, 1, 1],
    [1, 1, 1, 1],
    [2, 1, 1, 1],
    [3, 1, 1, 1],
    [2, 0, 0, 0],
    [1, 1, 1, 0],
    [2, 2, 0, 1]
  ]));
}

class Solution {
  List<List<int>> solution(int n, List<List<int>> buildFrame) {
    List<List<int>> answer = [];
    print('---build frame---');
    print(buildFrame);
    int count = 1;
    for (List<int> frame in buildFrame) {
      print('---build $count---');
      count++;
      int x = frame[0];
      int y = frame[1];
      int stuff = frame[2];
      int operate = frame[3];
      print('좌표 = ($x, $y)');
      print('작업물은 기둥 = ${stuff == 0}');
      print('작업물 추가 = ${operate == 1}');
      print(answer);
      if (operate == 0) {
        // 작업물 삭제
        // 우선삭제
        List<int> removeArray = [x, y, stuff];
        for (var element in answer) {
          if (element.toString() == removeArray.toString()) {
            answer.remove(element);
            break;
          }
        }
        // 삭제 가능한지 확인
        if (!operatePossible(answer)) {
          // 불가능한 경우 다시 추가
          answer.add(removeArray);
          print('delete not possible');
        } else {
          print('delete possible');
        }
        print(answer);
      }
      if (operate == 1) {
        // 작업물 설치
        // 우선 설치
        List<int> addArray = [x, y, stuff];
        answer.add(addArray);
        // 추가 가능한지 확인
        if (!operatePossible(answer)) {
          // 불가능한 경우 다시 삭제
          answer.removeLast();
          print('add not possible');
        } else {
          print('add possible');
        }
        print(answer);
      }
    }
    /*
        정렬기준
        1. x 기준으로 오름차순 정렬
        2. x 좌표가 같을경우 y좌표 기준으로 오름차순 정렬
        3. x, y 좌표가 모두 같을 경우 기둥이 보보다 먼저 오도록 정렬
    */
    print('---sort---');
    answer.sort((a, b) {
      if (a[0] == b[0]) {
        if (a[1] == b[1]) {
          if (a[2] > b[2]) {
            return 1;
          }
        } else if (a[1] > b[1]) {
          return 1;
        }
      } else if (a[0] > b[0]) {
        return 1;
      }
      return -1;
    });

    return answer;
  }

  bool operatePossible(List<List<int>> answer) {
    for (List<int> array in answer) {
      print('possible()');
      int x = array[0];
      int y = array[1];
      int stuff = array[2];
      if (stuff == 0) {
        // 기둥
        bool isOnFloor = y == 0; // 바닥위인지 판별
        List<int> pilar = [x, y - 1, 0]; // 다른 기둥 위인지 판별
        // 보의 한쪽 끝부분 위치하는지 판별
        List<int> beam1 = [x - 1, y, 1];
        List<int> beam2 = [x, y, 1];
        print('기둥');
        print('isOnFloor -> $isOnFloor');
        print('pilar -> $pilar');
        print('beam1 -> $beam1');
        print('beam2 -> $beam2');
        bool continueCheck = false;
        for (var element in answer) {
          if (isOnFloor ||
              element.toString() == pilar.toString() ||
              element.toString() == beam1.toString() ||
              element.toString() == beam2.toString()) {
            continueCheck = true;
            break;
          }
        }
        if (continueCheck) {
          continue;
        }
        return false;
      } else if (stuff == 1) {
        // 보
        // 한쪽 끝 부분이 기둥 위인지
        List<int> pilar1 = [x, y - 1, 0];
        List<int> pilar2 = [x + 1, y - 1, 0];
        // 양쪽 끝이 보와 연결되어 있는지
        List<int> beam1 = [x - 1, y, 1];
        List<int> beam2 = [x + 1, y, 1];
        print('보');
        print('pilar1 -> $pilar1');
        print('pilar2 -> $pilar2');
        print('beam1 -> $beam1');
        print('beam2 -> $beam2');
        bool continueCheck = false;
        int beamCheck = 0;
        for (var element in answer) {
          if (element.toString() == beam1.toString() ||
              element.toString() == beam2.toString()) {
            beamCheck++;
          }
          if (element.toString() == pilar1.toString() ||
              element.toString() == pilar2.toString() ||
              beamCheck == 2) {
            continueCheck = true;
            break;
          }
        }
        if (continueCheck) {
          continue;
        }
        return false;
      }
    }
    return true;
  }
}
/*
입력
입력
n = 5
build_frame = [[0,0,0,1],[2,0,0,1],[4,0,0,1],[0,1,1,1],[1,1,1,1],[2,1,1,1],[3,1,1,1],[2,0,0,0],[1,1,1,0],[2,2,0,1]]

과정
---build frame---
[[0, 0, 0, 1], [2, 0, 0, 1], [4, 0, 0, 1], [0, 1, 1, 1], [1, 1, 1, 1], [2, 1, 1, 1], [3, 1, 1, 1], [2, 0, 0, 0], [1, 1, 1, 0], [2, 2, 0, 1]]
---build 1---
좌표 = (0, 0)
작업물은 기둥 = true
작업물 추가 = true
[]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
add possible
[[0, 0, 0]]
---build 2---
좌표 = (2, 0)
작업물은 기둥 = true
작업물 추가 = true
[[0, 0, 0]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam1 -> [1, 0, 1]
beam2 -> [2, 0, 1]
add possible
[[0, 0, 0], [2, 0, 0]]
---build 3---
좌표 = (4, 0)
작업물은 기둥 = true
작업물 추가 = true
[[0, 0, 0], [2, 0, 0]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam1 -> [1, 0, 1]
beam2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0]]
---build 4---
좌표 = (0, 1)
작업물은 기둥 = false
작업물 추가 = true
[[0, 0, 0], [2, 0, 0], [4, 0, 0]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam1 -> [1, 0, 1]
beam2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1]]
---build 5---
좌표 = (1, 1)
작업물은 기둥 = false
작업물 추가 = true
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam1 -> [1, 0, 1]
beam2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam1 -> [0, 1, 1]
beam2 -> [2, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1]]
---build 6---
좌표 = (2, 1)
작업물은 기둥 = false
작업물 추가 = true
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam1 -> [1, 0, 1]
beam2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam1 -> [0, 1, 1]
beam2 -> [2, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam1 -> [1, 1, 1]
beam2 -> [3, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1]]
---build 7---
좌표 = (3, 1)
작업물은 기둥 = false
작업물 추가 = true
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam1 -> [1, 0, 1]
beam2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam1 -> [0, 1, 1]
beam2 -> [2, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam1 -> [1, 1, 1]
beam2 -> [3, 1, 1]
possible()
보
pilar1 -> [3, 0, 0]
pilar2 -> [4, 0, 0]
beam1 -> [2, 1, 1]
beam2 -> [4, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1]]
---build 8---
좌표 = (2, 0)
작업물은 기둥 = true
작업물 추가 = false
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam1 -> [0, 1, 1]
beam2 -> [2, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam1 -> [1, 1, 1]
beam2 -> [3, 1, 1]
possible()
보
pilar1 -> [3, 0, 0]
pilar2 -> [4, 0, 0]
beam1 -> [2, 1, 1]
beam2 -> [4, 1, 1]
delete possible
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1]]
---build 9---
좌표 = (1, 1)
작업물은 기둥 = false
작업물 추가 = false
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam1 -> [1, 1, 1]
beam2 -> [3, 1, 1]
delete not possible
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [2, 1, 1], [3, 1, 1], [1, 1, 1]]
---build 10---
좌표 = (2, 2)
작업물은 기둥 = true
작업물 추가 = true
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [2, 1, 1], [3, 1, 1], [1, 1, 1]]
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam1 -> [-1, 0, 1]
beam2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam1 -> [3, 0, 1]
beam2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam1 -> [-1, 1, 1]
beam2 -> [1, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam1 -> [1, 1, 1]
beam2 -> [3, 1, 1]
possible()
보
pilar1 -> [3, 0, 0]
pilar2 -> [4, 0, 0]
beam1 -> [2, 1, 1]
beam2 -> [4, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam1 -> [0, 1, 1]
beam2 -> [2, 1, 1]
possible()
기둥
isOnFloor -> false
pilar -> [2, 1, 0]
beam1 -> [1, 2, 1]
beam2 -> [2, 2, 1]
add not possible
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [2, 1, 1], [3, 1, 1], [1, 1, 1]]
---sort---

출력
[[0, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1], [4, 0, 0]]
*/
