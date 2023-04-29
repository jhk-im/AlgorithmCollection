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
            String[] input2 = br.readLine().split(" ");
            int[] array = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
            System.out.println("array=" + Arrays.toString(array));

            // 이진 탐색을 위한 시작점 끝점 설정
            int start = 0;
            int end = Arrays.stream(array).max().getAsInt();
            System.out.println("end=" + end);

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
                System.out.println("start=" + start + ", " + "mid=" + mid + ", " + "end=" + end + ", " + "total=" + total);
                if (total < m) {
                    System.out.println("왼쪽 탐색");
                    // 떡의 양이 부족한 경우 더 자르기 (왼쪽 탐색)
                    end = mid - 1;
                } else {
                    System.out.println("오른쪽 탐색");
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
/*
입력
4 6
19 15 10 17

출력
array=[19, 15, 10, 17]
end=19
start=0, mid=9, end=19, total=25
오른쪽 탐색
start=10, mid=14, end=19, total=9
오른쪽 탐색
start=15, mid=17, end=19, total=2
왼쪽 탐색
start=15, mid=15, end=16, total=6
오른쪽 탐색
start=16, mid=16, end=16, total=4
왼쪽 탐색
15
*/