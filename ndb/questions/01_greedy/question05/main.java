import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, m 입력받음
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int m = Integer.parseInt(input[1]);
            int[] array = new int[n];
            int arrayCount = 0;
            // 볼링공 리스트 입력받음
            while (arrayCount != n) {
                String[] input2 = br.readLine().split(" ");
                arrayCount = input2.length;
                if (arrayCount != n || Arrays.stream(array).max().getAsInt() > m) {
                    System.out.println("재입력");
                } else {
                    array = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
                    System.out.println("볼링공 리스트 => " + Arrays.toString(array));
                }
            }
            // 결과 확인
            int result = 0;
            for (int i = 0; i < n; i++){
                for (int j = i + 1; j < n; j++) {
                    if (array[i] != array[j]) {
                        result += 1;
                        System.out.println("index i = " + array[i]);
                        System.out.println("index j = " + array[j]);
                        System.out.println("result = " + result);
                    }
                }
            }
            System.out.println(result);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
5 3
1 3 2 3 2

출력
볼링공 리스트 => [1, 3, 2, 3, 2]
index i = 1
index j = 3
result = 1
index i = 1
index j = 2
result = 2
index i = 1
index j = 3
result = 3
index i = 1
index j = 2
result = 4
index i = 3
index j = 2
result = 5
index i = 3
index j = 2
result = 6
index i = 2
index j = 3
result = 7
index i = 3
index j = 2
result = 8
8
*/