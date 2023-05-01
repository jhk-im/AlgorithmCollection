import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n개의 부품 정수 입력
            String input = br.readLine();
            int n = Integer.parseInt(input);

            // 가게에 있는 전체 부품 번호 공백 구분하여 입력
            String[] input2 = br.readLine().split(" ");
            int[] nArray = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();

            if (Arrays.stream(nArray).max().isPresent()) {
                int[] array = new int[Arrays.stream(nArray).max().getAsInt() + 1];

                // 계수 정렬 활용
                for (int i : nArray) {
                    array[i] = 1;
                }

                // m개의 견적서 정수 입력
                String input3 = br.readLine();
                int m = Integer.parseInt(input3);

                // 견적서 전체 부품 번호 공백 구분하여 입력
                String[] input4 = br.readLine().split(" ");
                int[] mArray = Arrays.stream(input4).mapToInt(Integer::parseInt).toArray();

                System.out.println("nArray" + Arrays.toString(nArray));
                System.out.println("mArray" + Arrays.toString(mArray));

                // 견적서 부품 번호 하나씩 확인
                for (int target : mArray) {
                    System.out.println("target=" + target + " => " + Arrays.toString(array));
                    // 해당 부품이 존재하는지 확인
                    if (array[target] == 1) {
                        System.out.println("yes ");
                    } else {
                        System.out.println("no ");
                    }
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
nArray[8, 3, 7, 9, 2]
mArray[5, 7, 9]
target=5 => [0, 0, 1, 1, 0, 0, 0, 1, 1, 1]
no 
target=7 => [0, 0, 1, 1, 0, 0, 0, 1, 1, 1]
yes 
target=9 => [0, 0, 1, 1, 0, 0, 0, 1, 1, 1]
yes 
*/