import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayDeque;
import java.util.Deque;

public class Main {
    static int n = 0;
    static int m = 0;
    static int[][] graph;
    // 상, 하, 좌, 우 정의
    static int[] dc = {-1, 1, 0, 0};
    static int[] dr = {0, 0, -1, 1};
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, m 공백 구분 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);

            // 2차원 리스트 맵 정보 입력 받기
            graph = new int[n][m];
            for (int i = 0; i < n; i++) {
                BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
                String[] input2 = br2.readLine().split("");
                int[] row = new int[input2.length];
                for (int j = 0; j < input2.length; j++) {
                    row[j] = Integer.parseInt(input2[j]);
                }
                graph[i] = row;
            }

            System.out.println(bfs(0, 0)); // 정답 출력
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // BFS 소스코드
    private static int bfs(int c, int r) {
        // Queue 구현을 위한 deque 라이브러리 사용
        Deque<int[]> queue = new ArrayDeque<>();
        int[] q = {c, r};
        queue.addFirst(q);

        // 큐가 빌 때까지 반복
        while (!queue.isEmpty()) {
            int[] que = queue.removeLast();
            c = que[0];
            r = que[1];

            // 현재 위치에서 네 방향으로 위치 확인
            for (int i = 0; i < 4; i ++) {
                int nc = c + dc[i];
                int nr = r + dr[i];

                // 미로 공간을 벗어난 경우 무시
                if (nc < 0 || nr < 0 || nc >= n || nr >=m) {
                    continue;
                }

                // 벽인 경우 무시
                if (graph[nc][nr] == 0) {
                    continue;
                }

                // 노드를 처음 방문하는 경우에만 최단거리 기록
                if (graph[nc][nr] == 1) {
                    graph[nc][nr] = graph[c][r] + 1;
                    int[] q2 = { nc, nr };
                    queue.addFirst(q2);

//                    for (int[] ints : queue) {
//                        System.out.println(Arrays.toString(ints));
//                    }
//                    System.out.println(Arrays.toString(graph[0]));
//                    System.out.println(Arrays.toString(graph[1]));
//                    System.out.println(Arrays.toString(graph[2]));
//                    System.out.println("---");
                }
            }
        }
        return graph[n - 1][m - 1];
    }
}
