public class Main {
    public static void main(String[] args) {

        // 각 노드가 연결된 정보를 2차원 배열로 표현
        int[][] graph = {
                {},
                {2, 3},
                {6, 7},
                {4, 5},
                {3, 5},
                {4, 5},
                {2},
                {2}
        };

        // 각 노드 방문 정보
        boolean[] visited = new boolean[8];

        // dfs 호출
        dfs(graph, 1, visited); // 1 2 6 7 3 4 5 
    }


    // DFS 메서드 정의
    private static void dfs(int[][] graph, int v, boolean[] visited) {
        // 현재 노드 방문 체크
        visited[v] = true;
        System.out.print(v + " ");

        // 현재 노드의 인접 노드 재귀적 방문
        for(int i : graph[v]) {
            if (!visited[i]) {
                dfs(graph, i, visited);
            }
        }
    }
}
