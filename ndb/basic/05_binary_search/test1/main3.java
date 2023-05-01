import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n개의 부품 정수 입력
            String input = br.readLine();
            int n = Integer.parseInt(input);

            // 가게에 있는 전체 부품 번호 공백 구분하여 입력
            String[] input2 = br.readLine().split(" ");
            // 집합 자료형 활용
            Set<Integer> nSet = new HashSet<>();
            for (String s : input2) {
                nSet.add(Integer.parseInt(s));
            }

            // m개의 견적서 정수 입력
            String input3 = br.readLine();
            int m = Integer.parseInt(input3);

            // 견적서 전체 부품 번호 공백 구분하여 입력
            String[] input4 = br.readLine().split(" ");
            int[] mArray = Arrays.stream(input4).mapToInt(Integer::parseInt).toArray();

            System.out.println("nSet" + Arrays.toString(nSet.toArray()));
            System.out.println("mArray" + Arrays.toString(mArray));

            // 견적서 부품 번호 하나씩 확인
            for (int target : mArray) {
                // 해당 부품이 존재하는지 확인
                if (nSet.contains(target)) {
                    System.out.print("yes ");
                } else {
                    System.out.print("no ");
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

/*
입력
5
8 3 7 9 2
3
5 7 9

출력
nSet[2, 3, 7, 8, 9]
mArray[5, 7, 9]
no yes yes 
*/