import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // s 입력받음
            String[] array = br.readLine().split("");
            System.out.println("리스트 " + Arrays.toString(array));
            int count1 = 0; // 1 체크
            int count2 = 0; // 0 체크
            if (array[0].equals("1")) {
                count1++;
            } else {
                count2++;
            }
            for (int i = 1; i < array.length - 1; i++) {
                if (!array[i].equals(array[i + 1])) {
                    if (array[i + 1].equals("1")) {
                        count1++;
                    } else {
                        count2++;
                    }
                }
            }

            System.out.println(Math.min(count1, count2));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
0001100

출력
리스트 [0, 0, 0, 1, 1, 0, 0]
1
*/