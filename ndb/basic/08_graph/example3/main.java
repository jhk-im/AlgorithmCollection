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
            // 간선을 하나씩 확인
            for (int[] edge : edges) {
                int cost = edge[0];
                int a = edge[1];
                int b = edge[2];
                // 사이클이 발생하지 않은 경우 집합에 포함
                if (findParent(parent, a) != findParent(parent, b)) {
                    System.out.println("---NoCycle---");
                    unionParent(parent, a, b);
                    result += cost;
                } else {
                    System.out.println("---Cycle---");
                }
                System.out.println("cost,a,b=" + cost+ "," + a + "," + b);
            }
            // 결과 출력
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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
[12, 3, 4], [13, 2, 3], [23, 1, 2], [25, 1, 3], [32, 1, 4],
---NoCycle---
cost,a,b=12,3,4
---NoCycle---
cost,a,b=13,2,3
---NoCycle---
cost,a,b=23,1,2
---Cycle---
cost,a,b=25,1,3
---Cycle---
cost,a,b=32,1,4
48
*/