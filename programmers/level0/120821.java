import java.util.Collections;
import java.util.Arrays;
import java.util.List;

class Solution {
    // 배열 뒤집기
    public int[] solution(int[] num_list) {
        // boxed() -> 기본 데이터 유형을 해당 객체 래퍼 클래스로 변환, int => Integer
        // Arrays.asList -> Array와 List간의 변환
        // Collections.reverse() -> 리스트 순서 뒤집기
        // mapToInt() -> 스트림 각 요소를 다른 데이터 유형의 스트림으로 매핑
        // Integer::intValue -> Integer를 int로 반환
        List<Integer> numbers = Arrays.asList(Arrays.stream(num_list).boxed().toArray(Integer[]::new));
        Collections.reverse(numbers);
        return numbers.stream().mapToInt(Integer::intValue).toArray();
    }
}
