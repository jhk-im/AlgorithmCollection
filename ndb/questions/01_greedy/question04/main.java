import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n 입력받음
            String input = br.readLine();
            int n = Integer.parseInt(input);
            int[] array = new int[n];
            int arrayCount = 0;
            // 동전 리스트 입력받음
            while (arrayCount != n) {
                String[] input2 = br.readLine().split(" ");
                arrayCount = input2.length;
                if (arrayCount != n) {
                    System.out.println("재입력");
                } else {
                    array = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                    Arrays.sort(array);
                    System.out.println("리스트 오름차순 정렬 => " + Arrays.toString(array));
                }
            }

            // 결과확인
            int target = 1;
            for (int i : array) {
                System.out.println("i = " + i);
                System.out.println("target = " + target);
                boolean temp = target >= i;
                System.out.println("target >= i = " + temp);
                if (target >= i) {
                    target = target + i;
                }
                System.out.println("target + i = " + target);
            }
            System.out.println(target);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
5
3 1 1 2 9

출력
리스트 오름차순 정렬 => [1, 1, 2, 3, 9]
i = 1
target = 1
target >= i = true
target + i = 2
i = 1
target = 2
target >= i = true
target + i = 3
i = 2
target = 3
target >= i = true
target + i = 5
i = 3
target = 5
target >= i = true
target + i = 8
i = 9
target = 8
target >= i = false
target + i = 8
8
*/