import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    // 특정 원소가 속한 집합 찾기
    static int findParent(int[] parent, int x) {
        // 루트 노드가 아니라면, 루트 노드를 찾을 때 까지 재귀 호출
        /*if (parent[x] != x) {
            return findParent(parent, parent[x]);
        }
        return x;*/
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
            // 사이클 발생 여부
            boolean cycle = false;
            // union 연산 수행
            for (int i = 0; i < e; i++) {
                String[] input2 = br.readLine().split(" ");
                int a = Integer.parseInt(input2[0]);
                int b = Integer.parseInt(input2[1]);
                // 사이클 발생한 경우 종료
                if (findParent(parent, a) == findParent(parent, b)) {
                    cycle = true;
                    break;
                } else {
                    // 발생하지 않은경우 union 연산 수행
                    unionParent(parent, a, b);
                }
            }

            if (cycle) {
                System.out.println("사이클 o");
            } else {
                System.out.println("사이클 x");
            }
            System.out.println(Arrays.toString(parent));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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