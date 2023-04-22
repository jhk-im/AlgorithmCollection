import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    static int INF = 9999; // 무한을 의미하는 값
    static int n = 0;
    static int m = 0;
    static int[][] graph;
    public static void main(String[] args) {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n(노드 개수), m(간선 개수) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);

            // 2차원 리스트(그래프 표현) 생성
            graph = new int[n + 1][n + 1];
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
                String[] input3 = br.readLine().split(" ");
                // a번 노드에서 b번 노드로 가는 비용이 c
                int a = Integer.parseInt(input3[0]);
                int b = Integer.parseInt(input3[1]);
                int c = Integer.parseInt(input3[2]);
                graph[a][b] = c;
            }

            // 점화식에 따라 플로이드 위셜 알고리즘 수행
            for (int k = 1; k < n + 1; k++) {
                for (int a = 1; a < n + 1; a++) {
                    for (int b = 1; b < n + 1; b++) {
                        graph[a][b] = Math.min(graph[a][b], graph[a][k] + graph[k][b]);
                    }
                }
            }

            // 수행 결과 출력
            for (int a = 1; a < n + 1; a++) {
                for (int b = 1; b < n + 1; b++) {
                    if (graph[a][b] == INF) {
                        System.out.print("INF");
                    } else {
                        System.out.print(graph[a][b] + " ");
                    }
                }
                System.out.println(" ");
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

/*
입력
4 7
1 2 4
1 4 6
2 1 3
2 3 7
3 1 5
3 4 4
4 3 2

출력
0 4 8 6
3 0 7 9
5 9 0 4
7 11 2 0
*/
