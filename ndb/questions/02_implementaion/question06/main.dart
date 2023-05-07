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
      if (operate == 0) {
        // 작업물 삭제
        // 우선삭제
        List<int> removeArray = [x, y, stuff];
        answer.remove(removeArray);
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
        // 작업물 삭제
        // 우선 추가
        List<int> addArray = [x, y, stuff];
        answer.add(addArray);
        // 추가 가능한지 확인
        if (!operatePossible(answer)) {
          // 불가능한 경우 다시 삭제
          answer.remove(addArray);
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
        if (isOnFloor ||
            answer.contains(pilar) ||
            answer.contains(beam1) ||
            answer.contains(beam2)) {
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
        print('pilar1 -> ${answer.contains([x, y - 1, 0])}');
        print('pilar2 -> $pilar2');
        print('beam1 -> $beam1');
        print('beam2 -> $beam2');
        if (answer.contains(pilar1) ||
            answer.contains(pilar2) ||
            answer.contains(beam1) && answer.contains(beam2)) {
          continue;
        }
        return false;
      }
    }
    return true;
  }
}

// list in list contains 동작 오류 해결해야 함