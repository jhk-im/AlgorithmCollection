import java.util.HashSet;
import java.util.HashMap;

public class Main {

    /**
     * 문제
     * 1. 게임 캐릭터를 다음 4가지 명령어를 통해 이동하려 함
     * 1-1. U(위), D(아래), R(오른쪽), L(왼쪽) 각 한칸씩 이동
     * 2. (0, 0) 좌표에서 시작
     * 3. N(스테이지 길이) -> N + 1은 마지막 스테이지를 클리어한 사람을 표시하기 위함
     * 3-1. 경계는 LU(-5, 5), LD(-5, -5), RU(5, 5), RD(5, -5)
     * 4. 명령어 dirs 가 주어지고 게임 캐릭터가 이동한 후 처음 걸어본 길의 길이를 구해야 함
     * 5. dirs 길이는 500 이하 자연수
     * 문제 분석
     * 1. 중복 경로는 최종 길이에 포함되지 않음
     * 1-1. 중복을 포함하지 않는다는 조건이 나오면 HashSet 고려할 것
     * 2. 음수 좌표를 포함
     * 2-1. 배열에서는 음수 인덱스를 사용할 수 없음므로 시작 좌표를 (0, 0) -> (5, 5)로 변경하여 해결
     * 3. 이와같은 구현 문제는 코드가 길어지는 경우가 많으므로 기능별로 함수를 구현하는 것이 좋음
    **/

    // 경계를 벗어나는지 체크 - 벗어나는 경우는 무시
    // 좌표 문제에서 자주 사용됨
    private static boolean isValidMove(int nx, int ny) {
        return 0 <= nx && nx < 11 && 0 < ny && ny < 11;
    }

    // 다음 좌표 결정을 위한 해시맵
    // 방향에 따라 다음 좌표의 상대 위치를 얻음
    private static final HashMap<Character, int[]> location = new HashMap<>();

    private static void initLocation() {
        location.put('U', new int[]{0, 1});
        location.put('D', new int[]{0, -1});
        location.put('L', new int[]{-1, 0});
        location.put('R', new int[]{1, 0});
    }

    public static int solution(String dirs) {
        initLocation();
        int x = 5, y = 5;

        // 겹치는 좌표는 1개로 처리하기 위함
        HashSet<String> answer = new HashSet<>();

        // 주어진 명령어로 움직이면서 좌표 저장
        for (int i = 0; i < dirs.length(); i++) {
            int[] offset = location.get(dirs.charAt(i));
            int nx = x + offset[0];
            int ny = y + offset[1];

            // 벗어난 좌표는 인정하지 않음
            if (!isValidMove(nx, ny)) {
                continue;
            }

            // A -> B로 간 경우 B -> A도 추가
            // 이 문제에선 A->B, B->A를 모두 같은 경로로 취급함
            // 나중에 최종 이동 길이를 2로 나눔
            answer.add(x + " " + y + " " + nx + " " + ny);
            answer.add(nx + " " + ny + " " + x + " " + y);

            x = nx;
            y = ny;
        }

        return answer.size() / 2;
    }

    public static void main(String[] args) {
        System.out.println(solution("ULURRDLLU")); // 7
        System.out.println(solution("LULLLLLLU")); // 7
    }

    // N = dirs.length
    // dirs 길이만큼 순회
    // 최종 시간복잡도 -> O(N)
}
