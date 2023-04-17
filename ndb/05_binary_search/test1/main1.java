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
            // 이진 탐색을 위한 사전 정렬
            Arrays.sort(nArray);

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
                Object result = binarySearchWithWhile(nArray, target, 0, n - 1);

                if (result == null) {
                    System.out.print("no ");
                } else {
                    System.out.print("yes ");
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // 반복문 활용한 이진 탐색
    public static Object binarySearchWithWhile(int[] array, int target, int start, int end) {
        while (start <= end) {
            int mid = (start + end) / 2;
            if (array[mid] == target) {
                // 찾은 경우 중간점 인덱스 반환
                return mid;
            } else if (array[mid] > target) {
                // 중간점 값보다 target이 작으면 왼쪽 확인
                end = mid - 1;
            } else {
                // 중간점 값보다 target이 크면 오른쪽 확인
                start = mid + 1;
            }
        }

        return null;
    }
}
