import 'dart:collection';
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

    // 모든 간선을 담을 map, 최종비용
    Map<int, List<int>> hashMap = HashMap();
    int result = 0;
    // 간선 정보 입력받기
    for (int i = 0; i < e; i++) {
      var input = stdin.readLineSync()?.split(" ");
      if (input != null) {
        int a = int.parse(input[0]);
        int b = int.parse(input[1]);
        int cost = int.parse(input[2]);
        hashMap[cost] = [a, b];
      }
    }
    // 모든 간선을 담은 리스트
    List<MapEntry<int, List<int>>> edges = [];
    edges.addAll(hashMap.entries);
    // 간선을 비용순으로 정렬
    edges.sort((a, b) => a.key.compareTo(b.key));
    // 간선을 하나씩 확인
    for (MapEntry<int, List<int>> edge in edges.toList()) {
      int cost = edge.key;
      int a = edge.value[0];
      int b = edge.value[1];
      // 사이클이 발생하지 않은 경우 집합에 포함
      if (findParent(parent, a) != findParent(parent, b)) {
        print("Cycle O");
        unionParent(parent, a, b);
        result += cost;
      } else {
        print("Cycle X");
      }
      print('cost,a,b=$cost,$a,$b');
    }
    // 결과 출력
    print(result);
  }
}

/*
입력
4 5
1 2 23
1 3 25
1 4 32
2 3 13
3 4 12

출력
Cycle O
cost,a,b=12,3,4
Cycle O
cost,a,b=13,2,3
Cycle O
cost,a,b=23,1,2
Cycle X
cost,a,b=25,1,3
Cycle X
cost,a,b=32,1,4
48
*/