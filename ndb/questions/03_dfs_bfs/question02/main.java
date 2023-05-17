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
    static List<int[]> temp;
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            System.out.println("입력");
            // n, m 공백 구분 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);
            int[][] data = new int[n][m]; // 초기 맵 리스트
            int[][] defaultData = new int[n][m]; // debug용
            temp = new ArrayList<>(); // 벽을 설치한 뒤 맵 리스트
            // 지도의 정보 입력받기
            for (int i = 0; i < n; i++) {
                String[] input2 = br.readLine().split(" ");
                data[i] = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                defaultData[i] = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                temp.add(Arrays.stream(input2).mapToInt(Integer::parseInt).toArray());
            }
            System.out.println(" ");
            System.out.println("과정");
            dfs(0, data, defaultData);
            System.out.println(" ");
            System.out.println("출력");
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    // 깊이 우선 탐색(DFS)을 활용하여 바이러스가 사방에 퍼지도록 하는 함수
    static void virus(int x, int y) {
        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            // 상, 하, 좌, 우 중에서 바이러스가 퍼질 수 있는 경우
            if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                if (temp.get(nx)[ny] == 0) {
                    // 해당 위치에 바이러스 배치, 재귀 수행
                    temp.get(nx)[ny] = 2;
                    virus(nx, ny);
                }
            }
        }
    }
    // 벽을 설치한 맵의 안전영역 크기 계산
    static int getScore() {
        int score = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (temp.get(i)[j] == 0) {
                    score += 1;
                }
            }
        }
        return score;
    }
    static void dfs(int count, int[][] data, int[][] dataDebug) {
        // 울타리가 3개 설치된 경우
        if (count == 3) {
            temp.clear();
            for (int[] d : data) {
                int[] t = d.clone();
                temp.add(t);
            }
            // 바이러스 전파 진행
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < m; j++) {
                    if (temp.get(i)[j] == 2) {
                        virus(i, j);
                    }
                }
            }
            System.out.println("getScore = " + getScore());
            // 안전영역 최댓값 계산
            result = Math.max(result, getScore());
            return;
        }
        // 울타리 설치
        int depth = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (data[i][j] == 0) {
                    depth++;
                    data[i][j] = 1;
                    count += 1;
                    System.out.println(" ");
                    System.out.println("---카운트 증가---");
                    System.out.println("i = " + i);
                    System.out.println("j = " + j);
                    System.out.println("count = " + count);
                    System.out.println("depth = " + depth);
                    System.out.println("default data = " + Arrays.deepToString(dataDebug));
                    System.out.println("update data = " + Arrays.deepToString(data));
                    dfs(count, data, dataDebug);
                    data[i][j] = 0;
                    count -= 1;
                    System.out.println(" ");
                    System.out.println("---카운트 감소---");
                    System.out.println("i = " + i);
                    System.out.println("j = " + j);
                    System.out.println("count = " + count);
                    System.out.println("depth = " + depth);
                    System.out.println("default data = " + Arrays.deepToString(dataDebug));
                    System.out.println("update data = " + Arrays.deepToString(data));
                }
            }
        }
    }
}
/*
입력
3 3
1 0 1
2 0 0
0 0 1

과정

---카운트 증가---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 감소---
i = 1
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 감소---
i = 1
j = 2
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 감소---
i = 2
j = 0
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 0, 1]]

---카운트 감소---
i = 0
j = 1
count = 0
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 0, 1]]

---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 감소---
i = 1
j = 2
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 감소---
i = 2
j = 0
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 0, 1]]

---카운트 감소---
i = 1
j = 1
count = 0
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 0, 1]]

---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 1], [0, 0, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 0
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 0, 1]]

---카운트 감소---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 감소---
i = 2
j = 0
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 0, 1]]

---카운트 감소---
i = 1
j = 2
count = 0
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 0
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 0, 1]]

---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 0, 1]]

---카운트 감소---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [1, 0, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [1, 0, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 1
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 0, 1]]

---카운트 감소---
i = 1
j = 2
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 감소---
i = 2
j = 1
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 0, 1]]

---카운트 감소---
i = 2
j = 0
count = 0
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]

---카운트 증가---
i = 2
j = 1
count = 1
depth = 5
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 1
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [0, 1, 1]]

---카운트 감소---
i = 0
j = 1
count = 1
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 1, 0], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 1
j = 2
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2

---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [0, 1, 1]]

---카운트 감소---
i = 1
j = 1
count = 1
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 1], [0, 1, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 1], [0, 1, 1]]
getScore = 1

---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 2
j = 0
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [0, 1, 1]]

---카운트 감소---
i = 1
j = 2
count = 1
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]

---카운트 증가---
i = 2
j = 0
count = 2
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 증가---
i = 0
j = 1
count = 3
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 1, 1], [2, 0, 0], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 0
j = 1
count = 2
depth = 1
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 증가---
i = 1
j = 1
count = 3
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 1, 0], [1, 1, 1]]
getScore = 2

---카운트 감소---
i = 1
j = 1
count = 2
depth = 2
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 증가---
i = 1
j = 2
count = 3
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 1], [1, 1, 1]]
getScore = 0

---카운트 감소---
i = 1
j = 2
count = 2
depth = 3
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [1, 1, 1]]

---카운트 감소---
i = 2
j = 0
count = 1
depth = 4
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 1, 1]]

---카운트 감소---
i = 2
j = 1
count = 0
depth = 5
default data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]
update data = [[1, 0, 1], [2, 0, 0], [0, 0, 1]]

출력
2
*/
