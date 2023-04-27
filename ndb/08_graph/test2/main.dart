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
    // 모든 간선을 담을 리스트, 최종비용
    List<List<int>> edges = [];
    int result = 0;
    // 간선 정보 입력받기
    for (int i = 0; i < e; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        int cost = int.parse(input[2]);
        // 비용순으로 정렬하기 위해 key 를 원소 비용으로 설정
        List<int> list = [cost, a, b];
        edges.add(list);
      }
    }
    // 간선을 비용순으로 정렬
    edges.sort((a, b) => a[0].compareTo(b[0]));
    print(edges);
    // 최소 신장 트리에 포함되는 간선 중에서 가장 비용이 큰 간선
    int last = 0;
    // 간선을 하나씩 확인
    for (List<int> edge in edges) {
      int cost = edge[0];
      int a = edge[1];
      int b = edge[2];
      // 사이클이 발생하지 않은 경우 집합에 포함
      if (findParent(parent, a) != findParent(parent, b)) {
        unionParent(parent, a, b);
        result += cost;
        last = cost;
        print('---NoCycle---');
        print(parent);
        print('cost,a,b=$cost,$a,$b');
        print('result=$result');
        print('last=$last');
      } else {
        print('---Cycle---');
        print('cost,a,b=$cost,$a,$b');
      }
    }

    print(result - last);
  }
}

/*
입력
7 12
1 2 3
1 3 2
3 2 1
2 5 2
3 4 4
7 3 6
5 1 5
1 6 2
6 4 1
6 5 3
4 5 3
6 7 4

출력
[[1, 3, 2], [1, 6, 4], [2, 1, 3], [2, 2, 5], [2, 1, 6], [3, 1, 2], [3, 6, 5], [3, 4, 5], [4, 3, 4], [4, 6, 7], [5, 5, 1], [6, 7, 3]]
---NoCycle---
[0, 1, 2, 2, 4, 5, 6, 7]
cost,a,b=1,3,2
result=1
last=1
---NoCycle---
[0, 1, 2, 2, 4, 5, 4, 7]
cost,a,b=1,6,4
result=2
last=1
---NoCycle---
[0, 1, 1, 2, 4, 5, 4, 7]
cost,a,b=2,1,3
result=4
last=2
---NoCycle---
[0, 1, 1, 2, 4, 1, 4, 7]
cost,a,b=2,2,5
result=6
last=2
---NoCycle---
[0, 1, 1, 2, 1, 1, 4, 7]
cost,a,b=2,1,6
result=8
last=2
---Cycle---
cost,a,b=3,1,2
---Cycle---
cost,a,b=3,6,5
---Cycle---
cost,a,b=3,4,5
---Cycle---
cost,a,b=4,3,4
---NoCycle---
[0, 1, 1, 1, 1, 1, 1, 1]
cost,a,b=4,6,7
result=12
last=4
---Cycle---
cost,a,b=5,5,1
---Cycle---
cost,a,b=6,7,3
8
*/