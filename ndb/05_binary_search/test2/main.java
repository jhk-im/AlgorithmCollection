import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // 떡의 개수 n, 떡의 길이 m 입력
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);

            // 각 떡의 개별 높이 정보 입력
            BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
            String[] input2 = br2.readLine().split(" ");
            int[] array = new int[4];
            int count = 0;
            for (String s : input2) {
                array[count] = Integer.parseInt(s);
                count++;
            }

            // 이진 탐색을 위한 시작점 끝점 설정
            int start = 0;
            int end = Arrays.stream(array).max().getAsInt();

            // 이진 탐색
            int result = 0;
            while (start <= end) {
                int total = 0;
                int mid = (start + end) / 2;
                for (int target : array) {
                    // 잘랐을 때 떡의 양 계산
                    if (target > mid) {
                        total += target - mid;
                    }
                }
                if (total < m) {
                    // 떡의 양이 부족한 경우 더 자르기 (왼쪽 탐색)
                    end = mid - 1;
                } else {
                    // 떡의 양이 충분한 경우 덜 자르기 (오른쪽 탐색)
                    result = mid; // 최대한 덜 잘랐을 때가 정답
                    start = mid + 1;
                }
            }

            // 정답 출력
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
