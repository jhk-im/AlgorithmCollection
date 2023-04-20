import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // 정수 X 입력
            String input = br.readLine();
            int x = Integer.parseInt(input);

            // 계산된 결과를 저장하기 위한 DP 테이블
            int[] d = new int[30001];

            // 다나믹 프로그래밍 바텀업
            for (int i = 2; i < x + 1; i++){
                System.out.println(" ");
                System.out.println("---");
                System.out.print("i" + i);
                // 현재의 수에서 1을 빼는 경우
                d[i] = d[i - 1] + 1;
                System.out.print(" a" + d[i]);
                // 현재의 수가 2로 나누어 떨어지는 경우
                if (i % 2 == 0) {
                    d[i] = Math.min(d[i], d[i / 2] + 1);
                    System.out.print(" b" + d[i]);
                }
                // 현재의 수가 3으로 나누어 떨어지는 경우
                if (i % 3 == 0) {
                    d[i] = Math.min(d[i], d[i / 3] + 1);
                    System.out.print(" c" + d[i]);
                }
                // 현재의 수가 3으로 나누어 떨어지는 경우
                if (i % 5 == 0) {
                    d[i] = Math.min(d[i], d[i / 5] + 1);
                    System.out.print(" d" + d[i]);
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
