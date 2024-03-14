import java.util.ArrayList;
import java.util.Arrays;

public class Main {

    /**
     * 문제 분석
     * 1. 문제를 찍는 패턴을 분석
     * 2-1. 각 패턴으로 몇개를 맞출 수 있는지 체크
     * 2-2. 예외 상황을 찾음 -> 입력값이 패턴보단 긴 경우
     * 2-3. 답변이 패턴을 넘어가는 경우 패턴의 첫 번째부터 다시 계산하도록 설계
     * 3-1. 동점 조건을 주의해야함
     * 3-2. 각각의 최댓값을 먼저 구하고 그 값과 일치하는 패턴의 번호를 오름차순으로 반환하여 해결
    **/

    // 권장 시간복잡도 O(N)
    // N = answers.length
    public static int[] solution(int[] answers) {
        // 패턴
        // 하드코딩은 지양하는 것이 좋지만 확실히 사용해도 되는 경우 효율이 좋아짐
        int[][] pattern = {
                {1, 2, 3, 4, 5},
                {2, 1, 2, 3, 2, 4, 2 ,5},
                {3, 3, 1, 1, 2, 2, 4, 4, 5, 5}
        };

        // 점수를 저장할 배열
        int[] scores = new int[3];

        // 패턴과 입력값이 얼마나 일치하는지 확인 -> 시간복잡도 O(N)
        for (int i = 0; i < answers.length; i++) {
            for (int j = 0; j < pattern.length; j++) {
                if (answers[i] == pattern[j][i % pattern[j].length]) { // 2-3. 입력값이 패턴보다 긴 경우 처음부터 다시 비교하도록
                    scores[j]++;
                }
            }
        }

        // 최댓값
        int maxScore = Arrays.stream(scores).max().getAsInt();

        // 최댓갑과 일치하는 번호를 찾아 리스트에 추가 -> 시간복잡도 O(N)
        ArrayList<Integer> answer = new ArrayList<>();
        for (int i = 0; i < scores.length; i++) {
            if (scores[i] == maxScore) {
                answer.add(i + 1);
            }
        }

        return answer.stream().mapToInt(Integer::intValue).toArray();
    }

    public static void main(String[] args) {
        System.out.println(Arrays.toString(solution(new int[]{1, 2, 3, 4, 5}))); // [1]
        System.out.println(Arrays.toString(solution(new int[]{1, 3, 2, 4, 2}))); // [1, 2, 3]
    }

    // 최종 시간복잡도 -> O(N)
}
