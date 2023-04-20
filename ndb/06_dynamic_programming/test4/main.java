import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, m 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);

            // N개의 화폐 단위 정보 입력받기
            int[] array = new int[n];
            for (int i = 0; i < n; i++) {
                BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
                String input2 = br2.readLine();
                array[i] = Integer.parseInt(input2);
            }

            // 앞서 계산된 결과 저장하기 위한 DP 테이블
            int[] d = new int[m + 1];
            Arrays.fill(d, 10001);
            d[0] = 0;

            // 다나믹 프로그래밍 바텀업
            for (int i = 0; i < n; i++){
                for (int j = array[i]; j < m + 1; j++) {
                    if (d[j - array[i]] != 10001) { // (i - k) 방법 존재
                        d[j] = Math.min(d[j], d[j - array[i]] + 1);
                        System.out.println(Arrays.toString(d));
                    }
                }
            }

            // 최종 결과 출력
            if (d[m] == 10001) {
                // M원을 만드는 방법 없음
                System.out.println("-1");
            } else {
                System.out.println(d[m]);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
