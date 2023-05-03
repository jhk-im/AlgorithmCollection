import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // 문자열 s 입력받음
            String[] s = br.readLine().split("");
            // 문자열 리스트 오름차순 정렬
            Arrays.sort(s);
            System.out.println("sort -> " + Arrays.toString(s));
            // 숫자와 문자 판별
            int sum = 0;
            StringBuilder text = new StringBuilder();
            for (String value : s) {
                if (value.matches("^[0-9]+$")) { // 숫자 판별
                    System.out.println("sum += " + value);
                    sum += Integer.parseInt(value);
                } else {
                    System.out.println("text += " + value);
                    text.append(value);
                }
            }
            // 결과 출력
            System.out.println(text.toString() + sum);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
K1KA5CB7

과정
[1, 5, 7, A, B, C, K, K]
sum += 1
sum += 5
sum += 7
text += A
text += B
text += C
text += K
text += K

출력
ABCKK13
*/