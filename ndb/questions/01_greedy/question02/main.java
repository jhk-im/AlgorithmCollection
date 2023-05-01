import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // s 입력받음
            String[] input = br.readLine().split("");
            int[] array = new int[input.length];
            int count = 0;
            for (String s : input) {
                if (s.length() > 0) {
                    array[count] = Integer.parseInt(s);
                    count++;
                }
            }
            System.out.println("숫자 리스트 " + Arrays.toString(array));
            int result = 0;
            for (int i : array) {
                System.out.println("---");
                if (result <= 1 || i <= 1) {
                    System.out.println("더하기");
                    result += i;
                } else {
                    System.out.println("곱하기");
                    result *= i;
                }
                System.out.println(result);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
02984

출력
숫자 리스트 => [0, 2, 4, 8, 9]
---
더하기
0
---
더하기
2
---
곱하기
8
---
곱하기
64
---
곱하기
576
*/