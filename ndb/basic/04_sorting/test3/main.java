import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, k 공백 구분하여 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int k = Integer.parseInt(input[1]);

            int[] a = new int[n]; // 배열 A
            BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
            String[] input2 = br2.readLine().split(" ");
            for (int i = 0; i < input2.length; i++) {
                a[i] = Integer.parseInt(input2[i]);
            }
            Arrays.sort(a); // 베열 A 오름차순 정렬
            System.out.println("a => " + Arrays.toString(a));

            Integer[] b = new Integer[n]; // 배열 B
            BufferedReader br3 = new BufferedReader(new InputStreamReader(System.in));
            String[] input3 = br3.readLine().split(" ");
            for (int i = 0; i < input3.length; i++) {
                b[i] = Integer.parseInt(input3[i]);
            }
            Arrays.sort(b, Collections.reverseOrder()); // 배열 B 내림차순 정렬
            System.out.println("b => " + Arrays.toString(b));

            // 첫 번째 인덱스부터 확인하여 두 배열의 원소를 최대 K번 비교
            for (int i = 0; i < k; i++) {
                // A 원소가 B의 원소보다 작은 경우
                if (a[i] < b[i]) {
                    int temp = a[i];
                    a[i] = b[i];
                    b[i] = temp;
                    System.out.println("원소 교체");
                    System.out.println("a => " + Arrays.toString(a));
                    System.out.println("b => " + Arrays.toString(b));
                } else {
                    break;
                }
            }

            System.out.print(Arrays.stream(a).sum()); // 배열 A의 모든 원소 합 출력
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
5 3
1 2 5 4 3
5 5 6 6 5

출력
a => [1, 2, 3, 4, 5]
b => [6, 6, 5, 5, 5]
원소 교체
a => [6, 2, 3, 4, 5]
b => [1, 6, 5, 5, 5]
원소 교체
a => [6, 6, 3, 4, 5]
b => [1, 2, 5, 5, 5]
원소 교체
a => [6, 6, 5, 4, 5]
b => [1, 2, 3, 5, 5]
26
*/