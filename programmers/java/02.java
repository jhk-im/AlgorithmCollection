import java.util.Arrays;
import java.util.Collections;

public class Main {
    // 권장 시간 복잡도 O(NlogN)
    public static int[] solution(int[] arr) {
        // Stream = 데이터의 흐름
        // 반복문을 사용하지 않고 데이터를 다룰 수 있음 (가독성 향상)
        // 시간복잡도 측면에서 반복문과 스트림의 성능차이는 크게 없음
        // 다만 효율성이 떨어지는 상황에선 표준 API를 사용하는 것이 좋음
        // distinct() 시간복잡도 O(N) -> 이를 반복문으로 해결하면 O(N²)이 되므로 효율성이 떨어짐
        Integer[] result = Arrays.stream(arr).boxed().distinct().toArray(Integer[]::new); // boxed() -> Integer 변환 / distinct() 중복 제거
        Arrays.sort(result, Collections.reverseOrder()); // 내림차순 정렬
        return Arrays.stream(result).mapToInt(Integer::intValue).toArray();
    }

    // O(NlogN)
    // 정렬과 중복 제거를 동시에 할 수 있는 TreeSet을 사용
    public static int[] solution2(int[] arr) {
        TreeSet<Integer> set = new TreeSet<>(Collections.reverseOrder()); // 중복제거, 내림차순 정렬
        for (int num : arr) {
            set.add(num);
        }

        int[] result = new int[set.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = set.pollFirst();
        }
        return result;
    }

    public static void main(String[] args) {
        System.out.println(Arrays.toString(solution(new int[]{4, 2, 2, 1, 3, 4})));
        System.out.println(Arrays.toString(solution2(new int[]{2, 1, 1, 3, 2, 5, 4})));
    }

    // 시간복잡도 분석
    // N = arr.length
    // 중복 제거 -> O(N)
    // 정렬 -> O(NlogN)
}
