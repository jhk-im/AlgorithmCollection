import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static int INF = Integer.MAX_VALUE; // 무한을 의미하는 값
    static int n = 0;
    static int m = 0;

    static int[] distance;
    static List<List<List<Integer>>> graph;

    public static class CustomEntry {
        private final int key;
        private final int value;

        public CustomEntry(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    // 다익스트라 알고리즘 - 우선순위 큐 사용
    public static void dijkstra(int start) {
        // 시작 노드로 가기 위한 최단 경로는 0으로 설정
        PriorityQueue<CustomEntry> priorityQueue = new PriorityQueue<>(Comparator.comparingInt(x -> x.value));
        priorityQueue.add(new CustomEntry(0, start));
        // 시작 노드 초기화
        distance[start] = 0;
        // 큐가 비어있지 않다면
        while (!priorityQueue.isEmpty()) {
            System.out.println(Arrays.toString(distance));
            // 가장 최단 거리가 짤은 노드에 대한 정보 꺼내기
            CustomEntry poll = priorityQueue.poll();
            if (poll != null) {
                int dist = poll.key;
                int now = poll.value;

                for (CustomEntry c : priorityQueue.stream().toList()) {
                    System.out.println("("+ c.key + "," + c.value + ")");
                }

                // 현재 노드가 처리된 노드이면 무시
                if (distance[now] < dist) {
                    continue;
                }
                // 현재 노드와 연결된 다른 인접한 노드 확인
                for(List<Integer> i : graph.get(now)) {
                    int cost = dist + i.get(1);
                    if(cost < distance[i.get(0)]) {
                        distance[i.get(0)] = cost;
                        priorityQueue.add(new CustomEntry(cost, i.get(0)));
                    }
                }
            } else {
                break;
            }
        }
    }
    public static void main(String[] args) {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n(노드 개수), m(간선 개수), start(시작 노드) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);
            int start = Integer.parseInt(input[2]);

            // 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트
            graph = new ArrayList<>();
            for (int i = 0; i < n + 1; i++) {
                List<List<Integer>> list = new ArrayList<>();
                graph.add(list);
            }

            // 최단 거리 테이블 무한으로 초기화
            distance = new int[n + 1];
            Arrays.fill(distance, INF);

            // 모든 간선 정보 입력받기
            for (int i = 0; i < m; i++) {
                String[] input3 = br.readLine().split(" ");
                int x = Integer.parseInt(input3[0]);
                int y = Integer.parseInt(input3[1]);
                int z = Integer.parseInt(input3[2]);
                // x 노드에서 y 노드로 가는 비용 = z
                List<Integer> list = new ArrayList<>();
                list.add(y);
                list.add(z);
                graph.get(x).add(list);
            }

            // 다익스트라 알고리즘 수행
            System.out.println("dijkstra");
            dijkstra(start);

            // 도달할 수 있는 노드의 개수
            int count = 0;
            // 도달 가능한 노드 중 가장 멀리 있는 노드와의 최단 거리
            int maxDistance = 0;
            for (int d : distance) {
                // 도달 가능한 노드
                if (d != INF) {
                    count += 1;
                    maxDistance = Math.max(maxDistance, d);
                }
            }

            // 시작 노드 제외하기 위해 count -1
            System.out.println(count - 1 + ", " + maxDistance);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

/*
입력
3 2 1
1 2 4
1 3 2

출력
2 4
*/