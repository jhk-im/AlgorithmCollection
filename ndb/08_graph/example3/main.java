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
            // 모든 간선을 담을 map, 최종비용
            Map<Integer, int[]> hashMap = new HashMap<>();
            int result = 0;
            // 간선 정보 입력받기
            for (int i = 0; i < e; i++) {
                String[] input2 = br.readLine().split(" ");
                int a = Integer.parseInt(input2[0]);
                int b = Integer.parseInt(input2[1]);
                int cost = Integer.parseInt(input2[2]);
                int[] ab = {a, b};
                hashMap.put(cost, ab);
            }
            // 모든 간선을 담은 리스트
            List<Map.Entry<Integer, int[]>> edges = new ArrayList<>(hashMap.entrySet());
            // 간선을 비용순으로 정렬
            edges.sort(Map.Entry.comparingByKey());
            // 간선을 하나씩 확인
            for (Map.Entry<Integer, int[]> edge : edges.stream().toList()) {
                int cost = edge.getKey();
                int a = edge.getValue()[0];
                int b = edge.getValue()[1];
                // 사이클이 발생하지 않은 경우 집합에 포함
                if (findParent(parent, a) != findParent(parent, b)) {
                    System.out.println("Cycle O");
                    unionParent(parent, a, b);
                    result += cost;
                } else {
                    System.out.println("Cycle X");
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