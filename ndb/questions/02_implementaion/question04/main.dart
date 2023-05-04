void main(List<String> arguments) {
  Solution solution = Solution();
  print(solution.solution([
    [0, 0, 0],
    [1, 0, 0],
    [0, 1, 1]
  ], [
    [1, 1, 1],
    [1, 1, 0],
    [1, 0, 1]
  ]));
}

class Solution {
  bool solution(List<List<int>> key, List<List<int>> lock) {
    int n = lock.length;
    // 기존 자물쇠 크기의 3배 이차원 배열 생성
    int length = n * 3;
    List<List<int>> newLock = [];
    for (int i = 0; i < length; i++) {
      List<int> initLock = List.filled(length, 0);
      if (i >= n && i < n * 2) {
        for (int j = 0; j < length; j++) {
          if (j >= n && j < n * 2) {
            initLock[j] = lock[i - n][j - n];
          }
        }
      }
      newLock.add(initLock);
    }
    print("---newLock---");
    for (List<int> l in newLock) {
      print(l);
    }
    // 4가지 방향 확인
    for (int i = 0; i < 4; i++) {
      key = rotation(key); // 열쇠 회전
      // 자물쇠 끼워넣기
      for (int x = 1; x < n * 2; x++) {
        for (int y = 1; y < n * 2; y++) {
          updateLock(newLock, key, x, y);
          // 열쇠가 들어맞는지 검사
          if (check(newLock)) {
            return true;
          }
          // 자물쇠 초기화
          newLock = reset(newLock.length, lock);
        }
      }
    }
    return false;
  }

  // 자물쇠 초기화
  List<List<int>> reset(int newLockLength, List<List<int>> lock) {
    int n = lock.length;
    List<List<int>> temp = [];
    for (int i = 0; i < newLockLength; i++) {
      List<int> initLock = List.filled(newLockLength, 0);
      if (i >= n && i < n * 2) {
        for (int j = 0; j < newLockLength; j++) {
          if (j >= n && j < n * 2) {
            initLock[j] = lock[i - n][j - n];
          }
        }
      }
      temp.add(initLock);
    }
    return temp;
  }

  // 자물쇠가 모두 1인지 확인
  bool check(List<List<int>> locks) {
    double length = locks.length / 3;
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        if (locks[length.toInt() + i][length.toInt() + j] != 1) {
          return false;
        }
      }
    }
    return true;
  }

  // 자물쇠 맞춰 업데이트
  void updateLock(List<List<int>> newLock, List<List<int>> key, int x, int y) {
    int m = key.length;
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < m; j++) {
        newLock[x + i][y + j] += key[i][j];
      }
    }
    print("---update---");
    for (List<int> l in newLock) {
      print(l);
    }
  }

  // key 90도 회전
  List<List<int>> rotation(List<List<int>> key) {
    int length = key.length;
    List<List<int>> rotationKey = [for (var value in key) List.from(value)];
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        rotationKey[i][j] = key[length - 1 - j][i];
      }
    }
    print("---rotation---");
    for (List<int> l in rotationKey) {
      print(l);
    }
    return rotationKey;
  }
}
/*
입력
key = [[0, 0, 0], [1, 0, 0], [0, 1, 1]], lock [[1, 1, 1], [1, 1, 0], [1, 0, 1]]

---newLock---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---rotation---
[0, 1, 0]
[1, 0, 0]
[1, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 1, 0, 0, 0, 0, 0, 0]
[0, 1, 0, 0, 0, 0, 0, 0, 0]
[0, 1, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 0, 0, 0, 0]
[0, 0, 1, 0, 0, 0, 0, 0, 0]
[0, 0, 1, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 0, 0, 0, 0]
[0, 0, 0, 2, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 2, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 1, 0, 0]
[0, 0, 0, 0, 0, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 2, 0, 0, 0]
[0, 0, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 1, 0, 0, 0, 0, 0, 0]
[0, 1, 0, 1, 1, 1, 0, 0, 0]
[0, 1, 0, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 0, 0, 0, 0]
[0, 0, 1, 1, 1, 1, 0, 0, 0]
[0, 0, 1, 1, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 1, 0, 0, 0, 0]
[0, 0, 0, 2, 1, 1, 0, 0, 0]
[0, 0, 0, 2, 1, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 1, 0, 0, 0]
[0, 0, 0, 1, 2, 1, 0, 0, 0]
[0, 0, 0, 1, 2, 0, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 1, 0, 0]
[0, 0, 0, 1, 1, 2, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 1, 1, 1, 1, 0, 0, 0]
[0, 1, 0, 1, 1, 0, 0, 0, 0]
[0, 1, 0, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 2, 1, 1, 0, 0, 0]
[0, 0, 1, 1, 1, 0, 0, 0, 0]
[0, 0, 1, 1, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 2, 1, 0, 0, 0]
[0, 0, 0, 2, 1, 0, 0, 0, 0]
[0, 0, 0, 2, 0, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 2, 0, 0, 0]
[0, 0, 0, 1, 2, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 1, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 0, 2, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 1, 1, 1, 0, 0, 0, 0]
[0, 1, 0, 1, 0, 1, 0, 0, 0]
[0, 1, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 2, 1, 0, 0, 0, 0]
[0, 0, 1, 1, 0, 1, 0, 0, 0]
[0, 0, 1, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 2, 0, 0, 0, 0]
[0, 0, 0, 2, 0, 1, 0, 0, 0]
[0, 0, 0, 1, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
---update---
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 0, 1, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0]

출력
true
*/