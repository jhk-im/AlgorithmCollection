import java.util.ArrayDeque;
import java.util.Deque;

public class Main {
    public static void main(String[] args) {
        // 각 노드가 연결된 정보를 2차원 배열로 표현
        int[][] graph = {
                {},
                {2, 3},
                {6, 7},
                {4, 5},
                {3, 5},
                {3, 4},
                {2},
                {2}
        };

        // 각 노드 방문 정보
        boolean[] visited = new boolean[8];

        // dfs 호출
        bfs(graph, visited); // 1 2 3 6 7 4 5
    }

    // BFS 메서드 정의
    private static void bfs(int[][] graph, boolean[] visited) {
        // Queue 구현을 위한 deque 라이브러리 사용
        Deque<Integer> queue = new ArrayDeque<>();
        queue.addFirst(1);

        // 현재 노드 방문 체크
        visited[1] = true;

        // 큐가 빌 때까지 반복
        while (!queue.isEmpty()) {
            // 큐에서 원소를 출력
            int v = queue.removeLast();
            System.out.print(v + " ");

            // 해당 원소와 연결되고 아직 방문히자 않은 원소들 큐에 삽입
            for(int i : graph[v]) {
                if (!visited[i]) {
                    queue.addFirst(i);
                    visited[i] = true;
                }
            }
        }
    }
}
