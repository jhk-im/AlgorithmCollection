import 'dart:io';

// 특정 원소가 속한 집합 찾기
int findParent(List<int> parent, int x) {
  // 루트 노드가 아니라면, 루트 노드를 찾을 때 까지 재귀 호출
  /*if (parent[x] != x) {
    return findParent(parent, parent[x]);
  }
  return x;*/
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
  // v(노드 개수), e(간선 = union 연산) 공백 구분하여 입력 받기
  var input1 = stdin.readLineSync()?.split(" ");
  if (input1 != null) {
    int v = int.parse(input1[0]);
    int e = int.parse(input1[1]);
    // 부모를 테이블 생성
    List<int> parent = [];
    // 부모를 자기 자신으로 초기화
    for (int i = 0; i < v + 1; i++) {
      parent.add(i);
    }
    // 사이클 발생 여부
    bool cycle = false;
    // union 연산 수행
    for (int i = 0; i < e; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        // 사이클 발생한 경우 종료
        if (findParent(parent, a) == findParent(parent, b)) {
          cycle = true;
          break;
        } else {
          // 발생하지 않은경우 union 연산 수행
          unionParent(parent, a, b);
        }
      }
    }

    if (cycle) {
      print("사이클 o");
    } else {
      print("사이클 x");
    }
    print(parent);
  }
}

/*
입력
3 3
1 2
1 3
2 3

출력
사이클 o
[0, 1, 1, 1]
*/