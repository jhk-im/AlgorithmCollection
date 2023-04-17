import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n 입력 받기
            System.out.println("생성할 원소 개수, 찾을 문자열 입력. ex)3 Kim");
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            String target = input[1];

            System.out.println("원소 개수만큼 문자열 입력. ex)Lee Kim Park");
            BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
            String[] array = br2.readLine().split(" ");

            System.out.println(sequentialSearch(n, target, array));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // 순차 탐색
    public static int sequentialSearch(int n, String target, String[] array) {
        // 각 원소 하나씩 확인
        for (int i = 0; i < n; i++) {
            if (array[i].equals(target)) {
                return i + 1;
            }
        }
        return 0;
    }
}
