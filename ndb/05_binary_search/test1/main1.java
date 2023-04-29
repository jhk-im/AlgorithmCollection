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
            // 이진 탐색을 위한 사전 정렬
            Arrays.sort(nArray);

            // m개의 견적서 정수 입력
            String input3 = br.readLine();
            int m = Integer.parseInt(input3);

            // 견적서 전체 부품 번호 공백 구분하여 입력
            String[] input4 = br.readLine().split(" ");
            int[] mArray = Arrays.stream(input4).mapToInt(Integer::parseInt).toArray();
            // 이진 탐색을 위한 사전 정렬
            Arrays.sort(mArray);

            System.out.println("nArray" + Arrays.toString(nArray));
            System.out.println("mArray" + Arrays.toString(mArray));

            // 견적서 부품 번호 하나씩 확인
            for (int target : mArray) {
                // 해당 부품이 존재하는지 확인
                Object result = binarySearchWithWhile(nArray, target, 0, n - 1);

                if (result == null) {
                    System.out.println("no ");
                } else {
                    System.out.println("yes ");
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
            System.out.println("start=" + array[start] + ", " + "mid=" + array[mid] + ", " + "end=" + array[end] + ", ");
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
/*
입력
5
8 3 7 9 2
3
5 7 9

출력
nArray[2, 3, 7, 8, 9]
mArray[5, 7, 9]
start=2, mid=7, end=9, 
start=2, mid=2, end=3, 
start=3, mid=3, end=3, 
no 
start=2, mid=7, end=9, 
yes 
start=2, mid=7, end=9, 
start=8, mid=8, end=9, 
start=9, mid=9, end=9, 
yes 
*/