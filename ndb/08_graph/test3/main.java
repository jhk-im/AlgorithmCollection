import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // v(노드 개수) 입력 받기
            String input = br.readLine();
            int v = Integer.parseInt(input);
            // 모든 노드에 대한 진입차수 0으로 초기화
            int[] indegree = new int[v + 1];
            // 각 노드에 연결된 간선 정보를 담기 위한 연결리스트(그래프) 초기화
            List<List<Integer>> graph = new ArrayList<>();
            for (int i = 0; i < v + 1; i++) {
                graph.add(new ArrayList<>());
            }
            // 각 강의 시간을 0으로 초기화
            int[] time = new int[v + 1];
            // 방향 그래프의 모든 간선 정보 입력받기
            for (int i = 1; i < v + 1; i++) {
                String[] input2 = br.readLine().split(" ");
                int[] data = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                // 첫 번째 수는 시간 정보를 담고 있음
                time[i] = data[0];
                for (int j = 1; j < data.length - 1; j++) {
                    indegree[i] += 1;
                    graph.get(data[j]).add(i);
                }
            }
            System.out.print("graph=");
            System.out.println(graph);
            System.out.print("indegree=");
            System.out.println(Arrays.toString(indegree));
            System.out.print("time=");
            System.out.println(Arrays.toString(time));
            // 위상 정렬
            int[] result = time.clone(); // 알고리즘 수행결과를 담을 리스트
            Deque<Integer> queue = new ArrayDeque<>(); // Queue 구현을 위한 deque 라이브러리 사용
            // 처음 시작할 때 진입차수가 0인 노드 큐에삽입
            for (int i = 1; i < v + 1; i++) {
                if (indegree[i] == 0) {
                    queue.addFirst(i);
                }
            }
            // 큐가 빌때까지 반복
            while (!queue.isEmpty()) {
                // 큐에서 원소 꺼내기
                int now = queue.removeLast();
                System.out.print("pop=");
                System.out.println(now);
                for (int i : graph.get(now)) {
                    result[i] = Math.max(result[i], result[now] + time[i]);
                    // 해당 원소와 연결된 노드의 진입차수 1 빼기
                    indegree[i] -= 1;
                    // 진입차수가 0이 되는 노드 큐에 삽입
                    if (indegree[i] == 0) {
                        queue.addFirst(i);
                    }
                }
            }// 결과 출력
            System.out.print("result=");
            System.out.println(Arrays.toString(result));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
5
10 -1
10 1 -1
4 1 -1
4 3 1 -1
3 3 -1

출력
graph=[[], [2, 3, 4], [], [4, 5], [], []]
indegree=[0, 0, 1, 1, 2, 1]
time=[0, 10, 10, 4, 4, 3]
pop=1
pop=2
pop=3
pop=4
pop=5
result=[0, 10, 20, 14, 18, 17]
*/