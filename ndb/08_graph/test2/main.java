import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    // 특정 원소가 속한 집합 찾기
    static int findParent(int[] parent, int x) {
        // 경로 압축기법 사용
        if (parent[x] != x) {
            parent[x] =  findParent(parent, parent[x]);
        }
        return parent[x];
    }

    // 두 원소가 속한 집합 찾기
    static void unionParent(int[] parent, int a, int b) {
        a = findParent(parent, a);
        b = findParent(parent, b);
        if (a < b) {
            parent[b] = a;
        } else {
            parent[a] = b;
        }
    }

    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // v(노드 개수), e(간선 = union 연산) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            int v = Integer.parseInt(input[0]);
            int e = Integer.parseInt(input[1]);
            // 부모 테이블 초기화
            int[] parent = new int[v + 1];
            // 부모를 자기 자신으로 초기화
            for (int i = 0; i < v + 1; i++) {
                parent[i] = i;
            }
            // 모든 간선을 담을 리스트, 최종비용
            List<int[]> edges = new ArrayList<>();
            int result = 0;
            // 간선 정보 입력받기
            for (int i = 0; i < e; i++) {
                String[] input2 = br.readLine().split(" ");
                int a = Integer.parseInt(input2[0]);
                int b = Integer.parseInt(input2[1]);
                int cost = Integer.parseInt(input2[2]);
                // 비용순으로 정렬하기 위해 key 를 원소 비용으로 설정
                int[] list = {cost, a, b};
                edges.add(list);
            }
            // 간선을 비용순으로 정렬
            edges.sort((o1, o2) -> {
                if (o1[0] > o2[0]) {
                    return 1;
                } else if (o1[0] < o2[0])  {
                    return -1;
                }
                return 0;
            });
            for (int[] edge : edges) {
                System.out.print(Arrays.toString(edge) + ", ");
            }
            System.out.println(" ");
            // 최소 신장 트리에 포함되는 간선 중에서 가장 비용이 큰 간선
            int last = 0;
            // 간선을 하나씩 확인
            for (int[] edge : edges) {
                int cost = edge[0];
                int a = edge[1];
                int b = edge[2];
                // 사이클이 발생하지 않은 경우 집합에 포함
                if (findParent(parent, a) != findParent(parent, b)) {
                    unionParent(parent, a, b);
                    result += cost;
                    last = cost;
                    System.out.println("---NoCycle---");
                    System.out.println(Arrays.toString(parent));
                    System.out.println("cost=" + cost);
                    System.out.println("a=" + a);
                    System.out.println("b=" + b);
                    System.out.println("result=" + result);
                    System.out.println("last=" + last);
                } else {
                    System.out.println("---Cycle---");
                    System.out.println("cost=" + cost);
                    System.out.println("a=" + a);
                    System.out.println("b=" + b);
                }
            }
            // 결과출력
            System.out.println(result - last);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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
[1, 3, 2], [1, 6, 4], [2, 1, 3], [2, 2, 5], [2, 1, 6], [3, 1, 2], [3, 6, 5], [3, 4, 5], [4, 3, 4], [4, 6, 7], [5, 5, 1], [6, 7, 3],
---NoCycle---
[0, 1, 2, 2, 4, 5, 6, 7]
cost=1
a=3
b=2
result=1
last=1
---NoCycle---
[0, 1, 2, 2, 4, 5, 4, 7]
cost=1
a=6
b=4
result=2
last=1
---NoCycle---
[0, 1, 1, 2, 4, 5, 4, 7]
cost=2
a=1
b=3
result=4
last=2
---NoCycle---
[0, 1, 1, 2, 4, 1, 4, 7]
cost=2
a=2
b=5
result=6
last=2
---NoCycle---
[0, 1, 1, 2, 1, 1, 4, 7]
cost=2
a=1
b=6
result=8
last=2
---Cycle---
cost=3
a=1
b=2
---Cycle---
cost=3
a=6
b=5
---Cycle---
cost=3
a=4
b=5
---Cycle---
cost=4
a=3
b=4
---NoCycle---
[0, 1, 1, 1, 1, 1, 1, 1]
cost=4
a=6
b=7
result=12
last=4
---Cycle---
cost=5
a=5
b=1
---Cycle---
cost=6
a=7
b=3
8
*/