import java.util.Arrays;

public class Main {

    /**
     * 문제 분석
     * 1. 행렬 곱셈을 그대로 구현
     * 2. 각 배열의 최대 데이터 수가 100개이므로 시간복잡도는 신경쓰지 않아도 됨
     * 3. 곱할 수 있는 배열만 주어지므로 예외처리도 없음
    **/

    // 권장 시간복잡도 O(N³)
    // N = 행 or 열의 길이
    // r1 * c1 * c2 연산 -> r1, c1, c2 모두 N -> N³
    public static int[][] solution(int[][] arr1, int[][] arr2) {

        // arr1, arr2 행과 열의 수
        int r1 = arr1.length;
        int c1 = arr1[0].length;
        int c2 = arr2[0].length;

        // 결과를 저장할 2차원 배열
        int[][] answer = new int[r1][c2];

        // arr1 각 행, arr2 각 열에 대해 곱한 결과를 리스트에 추가
        for (int i = 0; i < r1; i++) {
            for (int j = 0; j < c2; j++) {
                for (int k = 0; k < c1; k++) {
                    answer[i][j] += arr1[i][k] * arr2[k][j];
                }
            }
        }

        return answer;
    }

    public static String arrayToString(int[][] array) {
        StringBuilder sb = new StringBuilder();
        for (int[] ints : array) {
            sb.append(Arrays.toString(ints));
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        System.out.println(arrayToString(solution(new int[][]{{1, 4}, {3, 2}, {4, 1}}, new int[][]{{3, 3}, {3, 3}}))); // [15, 15][15, 15][15, 15]
        System.out.println(arrayToString(solution(new int[][]{{2, 3, 2}, {4, 2, 4}, {3, 1, 4}}, new int[][]{{5, 4, 3}, {2, 4, 1}, {3, 1, 1}}))); // [22, 22, 11][36, 28, 18][29, 20, 14]
    }

    // 최종 시간복잡도 -> O(N³)
}
