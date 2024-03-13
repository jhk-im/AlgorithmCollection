import java.util.Arrays;

// 권장 시간 복잡도 O(NlogN)
// 제약 조건에 따라 같은 문제도 난이도가 달라질 수 있음
public class Main {

    // 시간복잡도 O(NlogN)
    public static int[] doSort(int[] org) {
        int[] arr = org.clone(); // 원본 배열의 상태를 유지하면서 새로운 배열을 복사해서 사용해야 하는 상황
        Arrays.sort(arr); // Dual-Pivot QuickSort or Tim-Sort 
        return arr;
    }

    // 시간복잡도 O(N²)
    public static int[] bubbleSort(int[] org) {
        int[] arr = org.clone(); // 원본 배열의 상태를 유지하면서 새로운 배열을 복사해서 사용해야 하는 상황
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    int tmp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = tmp;
                }
            }
        }
        return arr;
    }

    public static void main(String[] args) {
        int[] arr = new int[100000];
        long start = System.currentTimeMillis();
        int[] bubble = bubbleSort(arr);
        long end = System.currentTimeMillis();
        System.out.println((end - start) / 1000.0 + "초"); //  4.686초
      
        start = System.currentTimeMillis();
        int[] sort = doSort(arr);
        end = System.currentTimeMillis();
        System.out.println((end - start) / 1000.0 + "초");
        System.out.println(Arrays.equals(bubble, sort)); // 0.002초
    }

    // 시간복잡도 분석
    // Arrays.sort -> O(NlogN)
    // bubbleSort -> O(N²)
    // O(NlogN)
}
