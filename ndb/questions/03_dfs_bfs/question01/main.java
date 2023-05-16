import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            System.out.println("입력");
            // n, m, k, x 공백 구분 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);
            int k = Integer.parseInt(input[2]);
            int x = Integer.parseInt(input[3]);
            // 모든 도로 정보 입력받기
            List<List<Integer>> graph = new ArrayList<>();
            for (int i = 0; i < n + 1; i++) {
                graph.add(new ArrayList<>());
            }
            for (int i = 0; i < m; i++) {
                BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
                String[] input2 = br2.readLine().split(" ");
                int a = Integer.parseInt(input2[0]);
                int b = Integer.parseInt(input2[1]);
                graph.get(a).add(b);
            }
            System.out.println(" ");
            System.out.println("과정");
            System.out.println("graph = " + Arrays.deepToString(graph.toArray()));
            // 모든 도시에 대한 최단 거리 초기화
            int[] distance = new int[n + 1];
            Arrays.fill(distance, -1);
            // 출발 도시 까지의 거리는 0
            distance[x] = 0;
            // 너비 우선 탐색(BFS)
            Deque<Integer> queue = new ArrayDeque<>(); // Queue 구현을 위한 deque 라이브러리 사용
            queue.addFirst(x);
            while (!queue.isEmpty()) {
                int now = queue.removeLast();
                System.out.println("distance = " + Arrays.toString(distance));
                System.out.println("현재 도시 = " + now);
                // 현재 도시에서 이동할 수 있는 모든 도시 확인
                for (Integer next : graph.get(now)) {
                    // 방문하지 않은 도시
                    if (distance[next] == -1) {
                        System.out.println("방문하지 않은 도시 = " + next);
                        // 최단 거리 갱신
                        distance[next] = distance[now] + 1;
                        System.out.println("방문하지 않은 도시 최단거리 갱신 = " + distance[next]);
                        queue.addFirst(next);
                    }
                }
            }
            System.out.println(" ");
            System.out.println("출력");
            // 최단 거리가 K인 모든 도시의 번호 오름차순 출력
            boolean check = false;
            for (int i = 1; i < n + 1; i++) {
                if (distance[i] == k) {
                    System.out.println(i);
                    check = true;
                }
            }
            if (!check) {
                System.out.println(-1);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
6 6 2 1
1 2
1 3
2 4
3 5
4 6
5 6

과정
graph = [[], [2, 3], [4], [5], [6], [6], []]
distance = [-1, 0, -1, -1, -1, -1, -1]
현재 도시 = 1
방문하지 않은 도시 2
방문하지 않은 도시 최단거리 갱신 = 1
방문하지 않은 도시 3
방문하지 않은 도시 최단거리 갱신 = 1
distance = [-1, 0, 1, 1, -1, -1, -1]
현재 도시 = 2
방문하지 않은 도시 4
방문하지 않은 도시 최단거리 갱신 = 2
distance = [-1, 0, 1, 1, 2, -1, -1]
현재 도시 = 3
방문하지 않은 도시 5
방문하지 않은 도시 최단거리 갱신 = 2
distance = [-1, 0, 1, 1, 2, 2, -1]
현재 도시 = 4
방문하지 않은 도시 6
방문하지 않은 도시 최단거리 갱신 = 3
distance = [-1, 0, 1, 1, 2, 2, 3]
현재 도시 = 5
distance = [-1, 0, 1, 1, 2, 2, 3]
현재 도시 = 6

출력
4
5
*/
