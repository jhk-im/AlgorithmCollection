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
                System.out.println(" ");
            }
            System.out.println("결과=" + d[x]);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
26

출력
---
i2 a1 b1
---
i3 a2 c1
---
i4 a2 b2
---
i5 a3 d1
---
i6 a2 b2 c2
---
i7 a3
---
i8 a4 b3
---
i9 a4 c2
---
i10 a3 b2 d2
---
i11 a3
---
i12 a4 b3 c3
---
i13 a4
---
i14 a5 b4
---
i15 a5 c2 d2
---
i16 a3 b3
---
i17 a4
---
i18 a5 b3 c3
---
i19 a4
---
i20 a5 b3 d3
---
i21 a4 c4
---
i22 a5 b4
---
i23 a5
---
i24 a6 b4 c4
---
i25 a5 d2
---
i26 a3 b3
결과=3
*/