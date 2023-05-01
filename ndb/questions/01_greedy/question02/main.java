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
            Integer[] array = new Integer[n];
            int arrayCount = 0;
            // 공포도 리스트 입력 받음
            while (arrayCount != n) {
                String[] input2 = br.readLine().split(" ");
                arrayCount = input2.length;
                if (arrayCount != n) {
                    System.out.println("재입력");
                } else {
                    int count = 0;
                    for (String s : input2){
                        array[count] = Integer.parseInt(s);
                        count++;
                    }
                    Arrays.sort(array, Collections.reverseOrder());
                    System.out.println("공포도 리스트 내림차순 정렬 => " + Arrays.toString(array));
                }
            }
            // 결과확인
            int result = 0;
            int arraySize = n;
            int nextIndex = 0;
            while (nextIndex < n) {
                int limit = array[nextIndex]; // 3
                System.out.println("---");
                System.out.println("limit => " + limit);
                if (limit == 0) {
                    limit = 1;
                }
                if (limit <= arraySize) {
                    arraySize -= limit; // 2
                    nextIndex += limit; // 3
                    result += 1;
                } else {
                    arraySize -= 1;
                    nextIndex += 1;
                }
                System.out.println("arraySize => " + arraySize);
                System.out.println("nextIndex => " + nextIndex);
                System.out.println("result => " + result);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
/*
입력
5
2 3 1 2 2

출력
공포도 리스트 내림차순 정렬 => [3, 2, 2, 2, 1]
---
limit => 3
arraySize => 2
nextIndex => 3
result => 1
---
limit => 2
arraySize => 0
nextIndex => 5
result => 2
*/