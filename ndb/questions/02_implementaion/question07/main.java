import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        System.out.println("입력");
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            //  n(도시 크기), m(최대 치킨집 수) 입력받음
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);
            int[][] data = new int[n][n];
            ArrayList<int[]> house = new ArrayList<>();
            ArrayList<int[]> chicken = new ArrayList<>();
            ArrayList<ArrayList<int[]>> candidates = new ArrayList<>();
            // 집, 치킨집 정보 입력받음
            for (int r = 0; r < n; r++) {
                String[] input2 = br.readLine().split(" ");
                int[] array = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                data[r] = array;
                for (int c = 0; c < n; c++) {
                    int[] rc = {r, c};
                    if (data[r][c] == 1) {
                        house.add(rc); // 집
                    } else if (data[r][c] == 2) {
                        chicken.add(rc); // 치킨집
                    }
                }
            }
            System.out.println(" ");
            System.out.println("과정");
            for (int[] d : data) {
                System.out.println(Arrays.toString(d));
            }
            System.out.println("house = " + Arrays.deepToString(house.toArray()));
            System.out.println("chicken = " + Arrays.deepToString(chicken.toArray()));
            // 치킨집 순열 조합
            System.out.println("candidates");
            combination(chicken, candidates, new boolean[chicken.size()], 0, m);
            // 치킨 거리 합의 최소를 찾아 출력
            int result = 999999999;
            System.out.println("---getSum()---");
            for (ArrayList<int[]> candidate : candidates) {
                result = Math.min(result, getSum(house, candidate));
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
            ArrayList<int[]> chicken,
            ArrayList<ArrayList<int[]>> candidates,
            boolean[] visited,
            int start,
            int m) {
        if (m == 0) {
            ArrayList<int[]> candidate = new ArrayList<>();
            for (int v = 0; v < visited.length; v++) {
                if (visited[v]) {
                    candidate.add(chicken.get(v));
                }
            }
            System.out.println(Arrays.deepToString(candidate.toArray()));
            candidates.add(candidate);
            return;
        }
        for (int i = start; i < chicken.size(); i++) {
            visited[i] = true;
            combination(chicken, candidates, visited, i + 1, m - 1);
            visited[i] = false;
        }
    }
    // 치킨 거리의 합 계산
    static int getSum(ArrayList<int[]> house, ArrayList<int[]> candidate) {
        System.out.println("house -> " + Arrays.deepToString(house.toArray()));
        System.out.println("candidate -> " + Arrays.deepToString(candidate.toArray()));
        int result = 0;
        // 모든 집에 대하여
        for (int[] h : house) {
            // 가장 가까운 치킨집 찾기
            int temp = 999999999;
            for (int[] c : candidate) {
                temp = Math.min(temp, Math.abs(h[0] - c[0]) + Math.abs(h[1] - c[1]));
                System.out.print(temp + " ");
            }
            result += temp;
        }
        // 치킨 거리값 반환
        System.out.println(" ");
        System.out.println("return = " + result);
        return result;
    }
}
/*
입력
5 2
0 2 0 1 0
1 0 1 0 0
0 0 0 0 0
2 0 0 1 1
2 2 0 1 2

과정
[0, 2, 0, 1, 0]
[1, 0, 1, 0, 0]
[0, 0, 0, 0, 0]
[2, 0, 0, 1, 1]
[2, 2, 0, 1, 2]
house = [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
chicken = [[0, 1], [3, 0], [4, 0], [4, 1], [4, 4]]
candidates
[[0, 1], [3, 0]]
[[0, 1], [4, 0]]
[[0, 1], [4, 1]]
[[0, 1], [4, 4]]
[[3, 0], [4, 0]]
[[3, 0], [4, 1]]
[[3, 0], [4, 4]]
[[4, 0], [4, 1]]
[[4, 0], [4, 4]]
[[4, 1], [4, 4]]
---getSum()---
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [3, 0]]
2 2 2 2 2 2 5 3 6 4 6 4
return = 17
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [4, 0]]
2 2 2 2 2 2 5 4 6 5 6 3
return = 18
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [4, 1]]
2 2 2 2 2 2 5 3 6 4 6 2
return = 15
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[0, 1], [4, 4]]
2 2 2 2 2 2 5 2 6 1 6 1
return = 10
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[3, 0], [4, 0]]
6 6 2 2 4 4 3 3 4 4 4 3
return = 22
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[3, 0], [4, 1]]
6 6 2 2 4 4 3 3 4 4 4 2
return = 21
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[3, 0], [4, 4]]
6 5 2 2 4 4 3 2 4 1 4 1
return = 15
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[4, 0], [4, 1]]
7 6 3 3 5 4 4 3 5 4 3 2
return = 22
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[4, 0], [4, 4]]
7 5 3 3 5 5 4 2 5 1 3 1
return = 17
house -> [[0, 3], [1, 0], [1, 2], [3, 3], [3, 4], [4, 3]]
candidate -> [[4, 1], [4, 4]]
6 5 4 4 4 4 3 2 4 1 2 1
return = 17

출력
10
*/