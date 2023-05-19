import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    // 4가지 이동 방향에 대한 리스트
    static int[] dx = { -1, 0, 1, 0 };
    static int[] dy = { 0, 1, 0, -1 };
    static int n = 0;
    static int k = 0;
    static int target_s = 0;
    static int target_x = 0;
    static int target_y = 0;
    static int result = 0;
    static List<int[]> graph = new ArrayList<>(); // 전체 보드 정보를 담을 리스트
    static List<int[]> data = new ArrayList<>(); // 바이러스 정보를 담을 리스트
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            System.out.println("입력");
            // n, k 공백 구분 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            k = Integer.parseInt(input[1]);
            for (int i = 0; i < n; i++) {
                // 보드 정보를 한 줄 단위로 입력
                String[] input2 = br.readLine().split(" ");
                graph.add(Arrays.stream(input2).mapToInt(Integer::parseInt).toArray());
                for (int j = 0; j < n; j++) {
                    // 바이러스가 존재하는 경우
                    if (graph.get(i)[j] != 0) {
                        // {바이러스 종류, 시간, x, y} 바이러스 정보 추가
                        int[] virus = { graph.get(i)[j], 0, i, j };
                        data.add(virus);
                    }
                }
            }
            // 낮은 번호부터 확인하도록 오름차순 정렬
            data.sort(Comparator.comparingInt(virus -> virus[0]));
            // Queue 구현을 위한 deque 라이브러리 사용
            Deque<int[]> queue = new ArrayDeque<>();
            for (int[] virus : data) {
                queue.addFirst(virus);
            }
            // s, x, y 공백 구분 입력 받기
            String[] input3 = br.readLine().split(" ");
            target_s = Integer.parseInt(input3[0]);
            target_x = Integer.parseInt(input3[1]);
            target_y = Integer.parseInt(input3[2]);
            System.out.println(" ");
            System.out.println("과정");
            // 너비 우선 탐색(BFS)
            while (!queue.isEmpty()) {
                System.out.println("---check virus queue---");
                for (int[] virus : queue) {
                    System.out.println(Arrays.toString(virus));
                }
                int[] virusArray = queue.removeLast();
                System.out.println("check array = " + Arrays.toString(virusArray));
                int virus = virusArray[0];
                int s = virusArray[1];
                int x = virusArray[2];
                int y = virusArray[3];
                // s초가 지나거나 큐가 빌 때까지 반복
                if (s == target_s) {
                    break;
                }
                // 현재 바이러스 정보에서 상,하,좌,우 위치 각각 확인
                for (int i = 0; i < 4; i++) {
                    int nx = x + dx[i];
                    int ny = y + dy[i];
                    // 해당 위치로 이동할 수 있는 경우
                    if (0 <= nx && nx < n && 0 <= ny && ny < n) {
                        // 방문하지 않은 위치는 바이러스 추가
                        if (graph.get(nx)[ny] == 0) {
                            graph.get(nx)[ny] = virus;
                            int[] q = { virus, s + 1, nx, ny };
                            queue.addFirst(q);
                        }
                    }
                }
                System.out.println("update virus");
                for (int[] g : graph) {
                    System.out.println(Arrays.toString(g));
                }
            }
            System.out.println(" ");
            System.out.println("출력");
            result = graph.get(target_x - 1)[target_y - 1];
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
3 3
1 0 2
0 0 0
3 0 0
2 3 2

과정
---check virus queue---
[3, 0, 2, 0]
[2, 0, 0, 2]
[1, 0, 0, 0]
check array = [1, 0, 0, 0]
update virus
[1, 1, 2]
[1, 0, 0]
[3, 0, 0]
---check virus queue---
[1, 1, 1, 0]
[1, 1, 0, 1]
[3, 0, 2, 0]
[2, 0, 0, 2]
check array = [2, 0, 0, 2]
update virus
[1, 1, 2]
[1, 0, 2]
[3, 0, 0]
---check virus queue---
[2, 1, 1, 2]
[1, 1, 1, 0]
[1, 1, 0, 1]
[3, 0, 2, 0]
check array = [3, 0, 2, 0]
update virus
[1, 1, 2]
[1, 0, 2]
[3, 3, 0]
---check virus queue---
[3, 1, 2, 1]
[2, 1, 1, 2]
[1, 1, 1, 0]
[1, 1, 0, 1]
check array = [1, 1, 0, 1]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 0]
---check virus queue---
[1, 2, 1, 1]
[3, 1, 2, 1]
[2, 1, 1, 2]
[1, 1, 1, 0]
check array = [1, 1, 1, 0]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 0]
---check virus queue---
[1, 2, 1, 1]
[3, 1, 2, 1]
[2, 1, 1, 2]
check array = [2, 1, 1, 2]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 2]
---check virus queue---
[2, 2, 2, 2]
[1, 2, 1, 1]
[3, 1, 2, 1]
check array = [3, 1, 2, 1]
update virus
[1, 1, 2]
[1, 1, 2]
[3, 3, 2]
---check virus queue---
[2, 2, 2, 2]
[1, 2, 1, 1]
check array = [1, 2, 1, 1]

출력
3
*/
