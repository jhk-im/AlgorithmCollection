import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, target 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int target = Integer.parseInt(input[1]);

            BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
            String[] input2 = br2.readLine().split(" ");
            int[] array = new int[n];
            int count = 0;
            for (String s : input2) {
                array[count] = Integer.parseInt(s);
                count++;
            }

            Object result = binarySearch(array, target, 0, n - 1);
            if (result == null) {
                System.out.println("원소가 존재하지 않음");
            } else {
                System.out.println(Integer.parseInt(result.toString()) + 1);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // 이진 탐색 재귀 함수
    public static Object binarySearch(int[] array, int target, int start, int end) {
        if (start > end) {
            return null;
        }
        int mid = (start + end) / 2;
        if (array[mid] == target) { // 중간점 인덱스가 찾는 원소인 경우 반환
            return mid;
        } else if (array[mid] > target) { // 중간점 보다 찾는 원소가 작은 경우 왼쪽 확인
            return binarySearch(array, target, start, mid -1);
        } else { // 중간점 보다 찾는 원소가 큰 경우 오른쪽 확인
            return binarySearch(array, target, mid + 1, end);
        }
    }
}
