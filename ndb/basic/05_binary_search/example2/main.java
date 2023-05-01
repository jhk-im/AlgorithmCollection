import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n, target 입력 받기
            String[] input = br.readLine().split(" ");
            int n = Integer.parseInt(input[0]);
            int target = Integer.parseInt(input[1]);

            String[] input2 = br.readLine().split(" ");
            int[] array = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();

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
        System.out.println("start=" + array[start] + ", " + "mid=" + array[mid] + ", " + "end=" + array[end] + ", ");
        if (array[mid] == target) { // 중간점 인덱스가 찾는 원소인 경우 반환
            return mid;
        } else if (array[mid] > target) { // 중간점 보다 찾는 원소가 작은 경우 왼쪽 확인
            return binarySearch(array, target, start, mid -1);
        } else { // 중간점 보다 찾는 원소가 큰 경우 오른쪽 확인
            return binarySearch(array, target, mid + 1, end);
        }
    }

    // 반복문 활용한 이진 탐색
    public static Object binarySearchWithWhile(int[] array, int target, int start, int end) {
        while (start <= end) {
            int mid = (start + end) / 2;
            if (array[mid] == target) {
                return mid;
            } else if (array[mid] > target) {
                end = mid - 1;
            } else {
                start = mid + 1;
            }
        }

        return null;
    }
}
/*
입력
10 4
0 2 4 6 8 10 12 14 16 18

출력
start=0, mid=8, end=18, 
start=0, mid=2, end=6, 
start=4, mid=4, end=6, 
3
*/