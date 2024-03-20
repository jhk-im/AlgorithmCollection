import java.util.Arrays;

class Solution {
    // 입력된 배열의 평균값을 계산
    public double solution(int[] numbers) {
        // Arrays.stream(numbers) -> 배열을 스트림으로 변환하여 배열의 요소에 접근
        // average() -> 요소들의 평균값을 계산
        // orElse() -> 값이 존재하지 않을 때 대체값 제공
        // Double.NaN -> 숫자가 아님
        return Arrays.stream(numbers).average().orElse(Double.NaN);
    }
}
