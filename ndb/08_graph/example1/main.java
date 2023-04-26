import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    static int INF = Integer.MAX_VALUE; // 무한을 의미하는 값
    static int n = 0;
    static int m = 0;
    static int[] distance;
    static boolean[] visited;
    static List<List<List<Integer>>> graph;

    // 방문하지 않은 노드 중에서, 가장 최단 거리가 짧은 노드 반환
    public static int getSmallestNode() {
        int min_value = INF;
        int index = 0;
        for (int i = 1; i < n + 1; i++) {
            if (distance[i] < min_value && !visited[i]) {
                min_value = distance[i];
                index = i;
            }
        }
        return index;
    }

    // 다익스트라 알고리즘
    public static void dijkstra(int start) {
        // 시작 노드 초기화
        distance[start] = 0;
        visited[start] = true;
        for (List<Integer> j : graph.get(start)) {
            distance[j.get(0)] = j.get(1);
        }
        // 시작 노드를 제외한 전체 n - 1개의 노드에 대한 반복
        for (int i = 0; i < n - 1; i++) {
            // 현재 최단 거리가 가장 짧은 노드를 꺼내서, 방문 처리
            int now = getSmallestNode();
            visited[now] = true;
            // 현재 노드와 연결된 다른 노드 확인
            for(List<Integer> j : graph.get(now)) {
                int cost = distance[now] + j.get(1);
                // 현재 노드를 거쳐서 다른 노드로 이동하는 거리가 짧은 경우
                if (cost < distance[j.get(0)]) {
                    distance[j.get(0)] = cost;
                }
            }
            System.out.println(Arrays.toString(visited));
            System.out.println(Arrays.toString(distance));
        }
    }
    public static void main(String[] args) {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n(노드 개수), m(간선 개수) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);

            // 시작 노드 번호 입력
            String input2 = br.readLine();
            int start = Integer.parseInt(input2);

            // 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트
            graph = new ArrayList<>();
            for (int i = 0; i < n + 1; i++) {
                List<List<Integer>> list = new ArrayList<>();
                graph.add(list);
            }

            // 방문한 적이 있는지 체크하는 목적의 리스트
            visited = new boolean[n + 1];

            // 최단 거리 테이블 무한으로 초기화
            distance = new int[n + 1];
            Arrays.fill(distance, INF);
            distance[0] = 0;

            // 모든 간선 정보 입력받기
            for (int i = 0; i < m; i++) {
                String[] input3 = br.readLine().split(" ");
                int a = Integer.parseInt(input3[0]);
                int b = Integer.parseInt(input3[1]);
                int c = Integer.parseInt(input3[2]);
                // a번 노드에서 b번 노드로 가는 비용이 c
                List<Integer> list = new ArrayList<>();
                list.add(b);
                list.add(c);
                graph.get(a).add(list);
            }

            // 다익스트라 알고리즘 수행
            System.out.println("dijkstra");
            dijkstra(start);

            // 모든 노드로 가기 위한 최단 거리 출력
            System.out.println("결과");
            for (int i = 1; i < n + 1; i++) {
                // 도달할 수 없는 경우
                if (distance[i] == INF) {
                    System.out.println("INFINITY");
                } else {
                    // 도달 가능한 경우 거리 출력
                    System.out.print(distance[i]);
                }
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
