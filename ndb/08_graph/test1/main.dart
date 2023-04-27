import 'dart:io';

// 특정 원소가 속한 집합 찾기
int findParent(List<int> parent, int x) {
  // 경로 압축기법 사용
  if (parent[x] != x) {
    parent[x] = findParent(parent, parent[x]);
  }
  return parent[x];
}

// 두 원소가 속한 집합 찾기
void unionParent(List<int> parent, int a, int b) {
  a = findParent(parent, a);
  b = findParent(parent, b);
  if (a < b) {
    parent[b] = a;
  } else {
    parent[a] = b;
  }
}

void main(List<String> arguments) {
  // n(노드 개수), m(간선 = union 연산) 공백 구분하여 입력 받기
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    int n = int.parse(input1[0]);
    int m = int.parse(input1[1]);
    // 부모를 테이블 생성
    List<int> parent = [];
    // 부모를 자기 자신으로 초기화
    for (int i = 0; i < n + 1; i++) {
      parent.add(i);
    }
    // 각 연산을 하나씩 확인
    for (int i = 0; i < m; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        int oper = int.parse(input[0]);
        int a = int.parse(input[1]);
        int b = int.parse(input[2]);
        if (oper == 0) {
          // union 연산인 경우
          unionParent(parent, a, b);
        } else if (oper == 1) {
          // 찾기 연산인 경우
          print(parent);
          if (findParent(parent, a) == findParent(parent, b)) {
            print("YES");
          } else {
            print("NO");
          }
        }
      }
    }
  }
}

/*
7 8
0 1 3
1 1 7
[0, 1, 2, 1, 4, 5, 6, 7]
NO
0 7 6
1 7 1
[0, 1, 2, 1, 4, 5, 6, 6]
NO
0 3 7
0 4 2
0 1 2
1 6 4
[0, 1, 1, 1, 2, 5, 1, 6]
YES
*/