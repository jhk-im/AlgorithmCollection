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

            // 모든 식량정보 입력
            BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
            String[] input2 = br2.readLine().split(" ");
            int[] array = new int[n + 1];
            int count = 0;
            for (String s : input2) {
                array[count] = Integer.parseInt(s);
                count++;
            }

            // 앞서 계산된 결과 저장하기 위한 DP 테이블
            int[] d = new int[100];
            d[0] = array[0];
            d[1] = Math.max(array[0], array[1]);

            // 다나믹 프로그래밍 바텀업
            for (int i = 2; i < n + 1; i++){
                System.out.println("---");
                System.out.println("i -> " + i);
                System.out.println("d[i - 1] -> " + d[i - 1]);
                int temp = d[i - 2] + array[i];
                System.out.println("d[i - 1] + array[i] -> " + temp);
                d[i] = Math.max(d[i - 1], temp);
                System.out.println("d[i] -> " + d[i]);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
4
1 3 1 5

출력
---
i -> 2
d[i - 1] -> 3
d[i - 1] + array[i] -> 2
d[i] -> 3
---
i -> 3
d[i - 1] -> 3
d[i - 1] + array[i] -> 8
d[i] -> 8
---
i -> 4
d[i - 1] -> 8
d[i - 1] + array[i] -> 3
d[i] -> 8
*/