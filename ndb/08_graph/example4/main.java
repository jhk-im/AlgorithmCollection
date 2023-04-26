import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // v(노드 개수), e(간선 ) 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            int v = Integer.parseInt(input[0]);
            int e = Integer.parseInt(input[1]);
            // 모든 노드에 대한 진입차수 0으로 초기화
            int[] indegree = new int[v + 1];
            Arrays.fill(indegree, 0);
            // 각 노드에 연결된 간선 정보를 담기 위한 연결리스트(그래프) 초기화
            List<List<Integer>> graph = new ArrayList<>();
            for (int i = 0; i < v + 1; i++) {
                graph.add(new ArrayList<>());
            }

            // 방향 그래프의 간선 정보 입력받기
            for (int i = 0; i < e; i++) {
                String[] input2 = br.readLine().split(" ");
                int a = Integer.parseInt(input2[0]);
                int b = Integer.parseInt(input2[1]);
                // 정점 A에서 B로 이동 가능
                graph.get(a).add(b);
                // 진입차수 1 증가
                indegree[b] += 1;
            }
            System.out.print("graph=");
            System.out.println(graph);
            System.out.print("indegree=");
            System.out.println(Arrays.toString(indegree));
            // 위상 정렬
            List<Integer> result = new ArrayList<>();
            // Queue 구현을 위한 deque 라이브러리 사용
            Deque<Integer> queue = new ArrayDeque<>();
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
                result.add(now);
                System.out.print("pop=");
                System.out.println(now);
                for (int i : graph.get(now)) {
                    // 해당 원소와 연결된 노드의 진입차수 1 빼기
                    indegree[i] -= 1;
                    // 진입차수가 0이 되는 노드 큐에 삽입
                    if (indegree[i] == 0) {
                        queue.addFirst(i);
                    }
                }
            }
            // 결과 출력
            System.out.print("result=");
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
5 6
1 2
2 3
3 4
2 5
1 5
5 4

출력
graph=[[], [2, 5], [3, 5], [4], [], [4]]
indegree=[0, 0, 1, 1, 2, 2]
pop=1
pop=2
pop=3
pop=5
pop=4
result=[1, 2, 3, 5, 4]
*/