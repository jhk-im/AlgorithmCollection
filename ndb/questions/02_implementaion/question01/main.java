import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // 점수 n 입력받음
            String[] input = br.readLine().split("");
            int[] nArray = Arrays.stream(input).mapToInt(Integer::parseInt).toArray();
            int left = 0;
            int right = 0;
            // 절반 씩 더하기 연산
            for (int i = 0; i < nArray.length; i++) {
                if (i < nArray.length / 2) {
                    left += nArray[i];
                    System.out.println("left += " + nArray[i]);
                } else {
                    right += nArray[i];
                    System.out.println("right += " + nArray[i]);
                }
            }
            // 결과 출력
            if (left == right) {
                System.out.println("LUCKY");
            } else {
                System.out.println("READY");
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
123402

과정
left += 1
left += 2
left += 3
right += 4
right += 0
right += 2

출력
LUCKY
*/