import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    // 4가지 이동 방향에 대한 리스트
    static int[] dx = { -1, 0, 1, 0 };
    static int[] dy = { 0, 1, 0, -1 };
    static int n = 0;
    static int m = 0;
    static int result = 0;
    static List<int[]> updateData; // 업데이트용 맵
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            System.out.println("입력");
            // n, m 공백 구분 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);
            int[][] defaultData = new int[n][m]; // 초기화용 맵
            updateData = new ArrayList<>(); // 업데이트용 맵
            List<int[]> empties = new ArrayList<>(); // 빈칸 리스트
            // 지도의 정보 입력받기
            for (int i = 0; i < n; i++) {
                String[] input2 = br.readLine().split(" ");
                defaultData[i] = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                updateData.add(Arrays.stream(input2).mapToInt(Integer::parseInt).toArray());
                for (int j = 0; j < m; j++) {
                    if (updateData.get(i)[j] == 0) {
                        int[] xy = {i, j};
                        empties.add(xy);
                    }
                }
            }
            System.out.println(" ");
            System.out.println("과정");
            System.out.println("---빈칸 조합 리스트 생성---");
            List<List<int[]>> candidates = new ArrayList<>();
            combination(empties, candidates, new boolean[empties.size()], 0, 3);
            for (List<int[]> candidate : candidates) {
                System.out.println(" ");
                System.out.println("---벽추가---");
                resetMap(defaultData);
                for (int[] can : candidate) {
                    int x = can[0];
                    int y = can[1];
                    updateData.get(x)[y] = 1;
                }
                System.out.println("빈칸조합 = " + Arrays.deepToString(candidate.toArray()));
                System.out.println("default data = " + Arrays.deepToString(defaultData));
                System.out.println("update data = " + Arrays.deepToString(updateData.toArray()));
                checkVirus();
            }
            System.out.println(" ");
            System.out.println("출력");
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    // 백트래킹 조합
    static void combination(
            List<int[]> empties,
            List<List<int[]>> candidates,
            boolean[] visited,
            int start,
            int m) {
        if (m == 0) {
            ArrayList<int[]> candidate = new ArrayList<>();
            for (int v = 0; v < visited.length; v++) {
                if (visited[v]) {
                    candidate.add(empties.get(v));
                }
            }
            System.out.println(Arrays.deepToString(candidate.toArray()));
            candidates.add(candidate);
            return;
        }
        for (int i = start; i < empties.size(); i++) {
            visited[i] = true;
            combination(empties, candidates, visited, i + 1, m - 1);
            visited[i] = false;
        }
    }
    // 맵 초기화 함수
    static void resetMap(int[][] defaultData) {
        for (int i = 0; i < n; i++) {
            if (m >= 0) System.arraycopy(defaultData[i], 0, updateData.get(i), 0, m);
        }
    }
    // 깊이 우선 탐색(DFS)을 활용하여 바이러스가 사방에 퍼지도록 하는 함수
    static void checkVirus() {
        // 바이러스 전파 진행
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (updateData.get(i)[j] == 2) {
                    for (int v = 0; v < 4; v++) {
                        int nx = i + dx[v];
                        int ny = j + dy[v];
                        // 상, 하, 좌, 우 중에서 바이러스가 퍼질 수 있는 경우
                        if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                            if (updateData.get(nx)[ny] == 0) {
                                updateData.get(nx)[ny] = 2;
                            }
                        }
                    }
                }
            }
        }
        System.out.println("checkVirus() = " + Arrays.deepToString(updateData.toArray()));
        System.out.println("getScore() = " + getScore());
        // 안전영역 최댓값 계산
        result = Math.max(result, getScore());
    }
    // 벽을 설치한 맵의 안전영역 크기 계산
    static int getScore() {
        int score = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (updateData.get(i)[j] == 0) {
                    score += 1;
                }
            }
        }
        return score;
    }
}
/*
입력
3 3
1 0 1
2 0 0
0 0 1
 
과정
---빈칸 조합 리스트 생성---
[[0, 1], [1, 1], [1, 2]]
[[0, 1], [1, 1], [2, 0]]
[[0, 1], [1, 1], [2, 1]]
[[0, 1], [1, 2], [2, 0]]
[[0, 1], [1, 2], [2, 1]]
[[0, 1], [2, 0], [2, 1]]
[[1, 1], [1, 2], [2, 0]]
[[1, 1], [1, 2], [2, 1]]
[[1, 1], [2, 0], [2, 1]]
[[1, 2], [2, 0], [2, 1]]
 
---벽추가---
빈칸조합 = [[0, 1], [1, 1], [1, 2]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
checkVirus() = [[1, 1, 1], [2, 1, 1], [2, 2, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[0, 1], [1, 1], [2, 0]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
checkVirus() = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore() = 2
 
---벽추가---
빈칸조합 = [[0, 1], [1, 1], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
checkVirus() = [[1, 1, 1], [2, 1, 0], [2, 1, 1]]
getScore() = 1
 
---벽추가---
빈칸조합 = [[0, 1], [1, 2], [2, 0]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
checkVirus() = [[1, 1, 1], [2, 2, 1], [1, 2, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[0, 1], [1, 2], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
checkVirus() = [[1, 1, 1], [2, 2, 1], [2, 1, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[0, 1], [2, 0], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
checkVirus() = [[1, 1, 1], [2, 2, 2], [1, 1, 1]]
getScore() = 0
 
---벽추가---
빈칸조합 = [[1, 1], [1, 2], [2, 0]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
checkVirus() = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore() = 2
 
---벽추가---
빈칸조합 = [[1, 1], [1, 2], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
checkVirus() = [[1, 0, 1], [2, 1, 1], [2, 1, 1]]
getScore() = 1
 
---벽추가---
빈칸조합 = [[1, 1], [2, 0], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
checkVirus() = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore() = 2
 
---벽추가---
빈칸조합 = [[1, 2], [2, 0], [2, 1]]
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
checkVirus() = [[1, 2, 1], [2, 2, 1], [1, 1, 1]]
getScore() = 0
 
출력
2
*/
