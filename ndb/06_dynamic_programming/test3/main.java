import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // 정수 n 입력
            String input = br.readLine();
            int n = Integer.parseInt(input);

            // 앞서 계산된 결과 저장하기 위한 DP 테이블
            int[] d = new int[1001];
            d[1] = 1;
            d[2] = 3;

            // 다나믹 프로그래밍 바텀업
            for (int i = 3; i < n + 1; i++){
                System.out.println("---");
                System.out.println("i -> " + i);
                int d1 = d[i - 1];
                int d2 = d[i - 2];
                System.out.println("d1 -> " + d1);
                System.out.println("d2 -> " + d2);
                d[i] = (d1 + 2 * d2) % 796796;
                System.out.println("d[i] -> " + d[i]);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
