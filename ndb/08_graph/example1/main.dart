import 'dart:io';

// 특정 원소가 속한 집합 찾기
int findParent(List<int> parent, int x) {
  // 루트 노드가 아니라면, 루트 노드를 찾을 때 까지 재귀 호출
  if (parent[x] != x) {
    return findParent(parent, parent[x]);
  }
  return x;
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
    // union 연산 수행
    for (int i = 0; i < e; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        unionParent(parent, a, b);
      }
    }

    // 각 원소가 속한 집합 출력
    print("각 원소가 속한 집합");
    for (int i = 1; i < v + 1; i++) {
      print('$i의 루트 = ${findParent(parent, i)}');
    }

    // 부모 테이블 내용 출력
    print("부모 테이블");
    print(parent);
  }
}

/*
입력
6 4
1 4
2 3
2 4
5 6

출력
각 원소가 속한 집합
1의 루트 = 1
2의 루트 = 1
3의 루트 = 1
4의 루트 = 1
5의 루트 = 5
6의 루트 = 5
부모 테이블
[0, 1, 1, 2, 1, 5, 5]
*/