import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {

    static int n = 0;
    static int m = 0;
    static int[][] graph;

    static boolean dfs(int c, int r) {
        // 주어진 범위를 벗어나는 경우 즉시 종료
        if (c <= -1 || c >= n || r <= -1 || r >= m) {
            return false;
        }

        // 현재 노드를 방문하지 않은 경우
        if (graph[c][r] == 0) {
            // 해당 노드 방문 처리
            graph[c][r] = 1;

            // 상, 하, 좌, 우 재귀 호출
            dfs(c - 1, r); // 상
            dfs(c + 1, r); // 하
            dfs(c, r - 1); // 좌
            dfs(c, r + 1); // 우

            return true;
        }

        return false;
    }

    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, m 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            n = Integer.parseInt(input[0]);
            m = Integer.parseInt(input[1]);

            // 2차원 리스트 맵 정보 이력 받기
            int[][] array = new int[n][m]; // 배열 A
            for (int i = 0; i < n; i++) {
                BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
                String[] input2 = br2.readLine().split("");
                int[] intArray = new int[m];
                int count = 0;
                for (String s : input2) {
                    if (s.length() > 0) {
                        intArray[count] = Integer.parseInt(s);
                        count++;
                    }
                }
                array[i] = intArray;
                //System.out.println(Arrays.toString(intArray));
            }

            graph = array;

            // 모든 노드에 대하여 음료수 채우기
            var result = 0;
            for (int i = 0; i < n; i++) {
                for(int j = 0; j < m; j++) {
                    // 현재 위치에서 dfs 수행
                    if (dfs(i, j)) {
                        result += 1;
                    }
                }
            }

            System.out.println(result); // 정답 출력
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}