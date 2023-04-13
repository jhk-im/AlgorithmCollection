import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Collections;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n 입력 받기
            String input = br.readLine();
            int n = Integer.parseInt(input);

            Integer[] array = new Integer[n];

            // 2차원 리스트 맵 정보 입력 받기
            for (int i = 0; i < n; i++) {
                BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
                String input2 = br2.readLine();
                array[i] = Integer.parseInt(input2);
            }

            // 자바 기본 정렬 라이브러리로 내림차순 정렬 수행
            Arrays.sort(array, Collections.reverseOrder());

            for (int i : array) {
                System.out.print(i + " "); // 정답 출력
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
