import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) {
        int INF = 9999; // 무한을 의미하는 값
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n(노드 개수), m(간선 개수) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);

            // 2차원 리스트(그래프 표현) 생성
            int[][] graph = new int[n + 1][n + 1];
            for (int i = 0; i < n + 1; i++) {
                for (int j = 0; j < n + 1; j++) {
                    // 첫번째 column, row = 0
                    // 자기 자신에게 가는 비용 = 0
                    if (i > 0 && j > 0 && i != j) {
                        // 이외의 값은 무한으로 초기화
                        graph[i][j] = INF;
                    }
                    System.out.print(graph[i][j] + " ");
                }
                System.out.println(" ");
            }

            // 각 간선에 대한 정보를 입력받아 초기화
            for (int i = 0; i < m; i++) {
                String[] input2 = br.readLine().split(" ");
                // a번 노드에서 b번 노드로 가는 비용이 c
                int a = Integer.parseInt(input2[0]);
                int b = Integer.parseInt(input2[1]);
                graph[a][b] = 1;
                graph[b][a] = 1;
            }

            // 거쳐갈 노드 x, 최종 목적지 k 이력
            String[] input3 = br.readLine().split(" ");
            int x = Integer.parseInt(input3[0]);
            int k = Integer.parseInt(input3[1]);

            // 점화식에 따라 플로이드 위셜 알고리즘 수행
            for (int i = 1; i < n + 1; i++) {
                for (int a = 1; a < n + 1; a++) {
                    for (int b = 1; b < n + 1; b++) {
                        graph[a][b] = Math.min(graph[a][b], graph[a][i] + graph[i][b]);
                    }
                }
            }

            // 수행 결과 출력
            int distance = graph[1][k] + graph[k][x];
            if (distance >= INF) {
                System.out.println("-1");
            } else {
                System.out.println(distance);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

/*
입력
5 7
1 2
1 3
1 4
2 4
3 4
3 5
4 5
4 5

출력
3

입력2
4 2
1 3
2 4
3 4

출력2
-1
*/