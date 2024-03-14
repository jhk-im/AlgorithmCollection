import java.util.HashSet;
import java.util.Arrays;

public class Main {

    // 권장 시간복잡도 O(N²log(N²))
    public static int[] solution(int[] numbers) {
        HashSet<Integer> set = new HashSet<>(); // 중복값 제거를 위함
        
        // 이중 반복문을 사용한 두수의 합 -> 시간복잡도 O(N²)
        for (int i = 0; i < numbers.length - 1; i++) {
            for (int j = i + 1; j < numbers.length; j++) {
                // Set 생성시 시간복잡도 -> O(N²)
                set.add(numbers[i] + numbers[j]);
            }
        }
        
        // sorted() -> 오름차순 정렬 -> 시간복잡도 O(N²log(N²))
        // Integer::intValue -> Integer 객체를 int 값으로 매핑
        return set.stream().sorted().mapToInt(Integer::intValue).toArray();
    }

    public static void main(String[] args) {
        System.out.println(Arrays.toString(solution(new int[]{5, 0, 2, 7})));
    }
    
    // 최종 시간복잡도 -> O(N²log(N²))
}
