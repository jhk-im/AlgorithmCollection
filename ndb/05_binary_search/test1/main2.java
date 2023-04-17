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
            BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
            String[] input2 = br2.readLine().split(" ");
            int[] nArray = new int[n];
            int count = 0;
            for (String s : input2) {
                nArray[count] = Integer.parseInt(s);
                count++;
            }

            if (Arrays.stream(nArray).max().isPresent()) {
                int[] array = new int[Arrays.stream(nArray).max().getAsInt() + 1];

                // 계수 정렬 활용
                for (int i : nArray) {
                    array[i] = 1;
                }

                // m개의 견적서 정수 입력
                BufferedReader br3 = new BufferedReader(new InputStreamReader(System.in));
                String input3 = br3.readLine();
                int m = Integer.parseInt(input3);

                // 견적서 전체 부품 번호 공백 구분하여 입력
                BufferedReader br4 = new BufferedReader(new InputStreamReader(System.in));
                String[] input4 = br4.readLine().split(" ");
                int[] mArray = new int[m];
                int count2 = 0;
                for (String s : input4) {
                    mArray[count2] = Integer.parseInt(s);
                    count2++;
                }

                // 견적서 부품 번호 하나씩 확인
                for (int target : mArray) {
                    // 해당 부품이 존재하는지 확인
                    if (array[target] == 1) {
                        System.out.print("yes ");
                    } else {
                        System.out.print("no ");
                    }
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
