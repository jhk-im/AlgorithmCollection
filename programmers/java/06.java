import java.util.Arrays;
import java.util.HashMap;

public class Main {

    /**
     * 문제 분석
     * 1. 새로운 용어를 정의하는 부분은 반드시 이해하고 넘어가야 함
     * 1-1. (용어)실패율 -> 스테이지에 도달한 적이 있는 사용자 중 아직 클리어하지 못한 사용자 비율
     * 2. 스테이지 1 -> 스테이지 1을 아직 클리어하지 않은 사용자
     * 3. N(스테이지 길이) -> N + 1은 마지막 스테이지를 클리어한 사람을 표시하기 위함
     * 4. 각 실패율을 구하고 내림차순으로 정렬하여 반환
     * 5. 스테이지가 20만 까지 입력될 수 있으므로 시간 복잡도는 O(NlogN)이 되어야 함
     * 5-1. 정렬 문제는 표준 API 를 사용하는 것이 좋은 전략
    **/

    // 권장 시간복잡도 O(M+NlogN)
    // M = stages.length
    public static int[] solution(int N, int[] stages) {
        // 스테이지 도전자 수
        // N+2 -> 0번째 인덱스는 사용하지 않고 마지막 스테이지 클리어한 사용자를 추가하기 위함
        // stage 값을 challenger 인덱스로 사용할 수 있는 이점
        // 이와 유사한 정렬 알고리즘 -> 계수정렬
        int[] challenger = new int[N + 2];
        for (int stage : stages) { // 시간복잡도 O(N + M)
            challenger[stage] += 1;
        }

        // 스테이지별 실패한 사용자 수
        // HashMap key = 스테이지 번호, value = 실패율
        HashMap<Integer, Double> fails = new HashMap<>();
        // total 을 int 로 하는 경우 실패율 계산시 0 혹은 1이 되어 오답이 안올 수 있음
        double total = stages.length;
        // i = 1 -> 번째 인덱스는 제외
        for (int i = 1; i <= N; i++) { // 시간복잡도 O(N)
            if (challenger[i] == 0) { // 도전자 없음
                fails.put(i, 0.);
            }
            else {
                fails.put(i, challenger[i] / total); // 실패율 계산하여 추가
                total -= challenger[i]; // 현재 스테이지 인원 제거
            }
        }
        // sorted((o1, 02) -> Double.compare(o2.getValue(), o1.getValue())) -> 내림차순 정렬 -> 시간복잡도 O(NlogN)
        // Double.compare -> 첫번째 값보다 두번째 값이 크면 음수, 반대면 양수, 같으면 0
        // .mapToInt(HashMap.Entry::getKey).toArray() -> 키만 배열에 담음
        return fails.entrySet().stream().sorted((o1, o2) -> Double.compare(o2.getValue(), o1.getValue())).mapToInt(HashMap.Entry::getKey).toArray();
    }

    public static void main(String[] args) {
        System.out.println(Arrays.toString(solution(5, new int[]{2, 1, 2, 6, 2, 4, 3, 3}))); // [3, 4, 2, 1, 5]
        System.out.println(Arrays.toString(solution(4, new int[]{4, 4, 4, 4, 4}))); // [4, 1, 2, 3]
    }

    // 위에서 고려한 모든 시간복잡도 O(N + M) + O(N) + O(NlogN) -> O(2*N + M + NlogN)
    // 최종 시간복잡도 -> O(M + NlogN)
}
