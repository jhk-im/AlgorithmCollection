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
            // n(노드 개수), m(간선 = union 연산) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);
            // 부모 테이블 초기화
            int[] parent = new int[n + 1];
            // 부모를 자기 자신으로 초기화
            for (int i = 0; i < n + 1; i++) {
                parent[i] = i;
            }
            // 각 연산을 하나씩 확인
            for (int i = 0; i < m; i++) {
                String[] input2 = br.readLine().split(" ");
                int oper = Integer.parseInt(input2[0]);
                int a = Integer.parseInt(input2[1]);
                int b = Integer.parseInt(input2[2]);
                if (oper == 0) { // union 연산인 경우
                    unionParent(parent, a, b);
                } else if (oper == 1) { // 찾기 연산인 경우
                    System.out.println(Arrays.toString(parent));
                    if (findParent(parent, a) == findParent(parent, b)) {
                        System.out.println("YES");
                    } else {
                        System.out.println("NO");
                    }
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
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