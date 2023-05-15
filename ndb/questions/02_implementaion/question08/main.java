import java.util.*;
public class Main {
    public static void main(String[] args) {
        Solution solution = new Solution();
        int[] weak = {1, 3, 4 ,9, 10};
        int[] dist = {3, 5, 7};
        System.out.println(solution.solution(12, weak, dist));
    }
}
class Solution {
    public int solution(int n, int[] weak, int[] dist) {
        int length = weak.length;
        // weak 길이를 2배 늘려 원형을 일자 형태로 변형
        int[] newWeak = new int[weak.length * 2];
        for (int i = 0; i < weak.length * 2; i++) {
            if (i < weak.length) {
                newWeak[i] = weak[i];
            } else {
                newWeak[i] = weak[i - weak.length] + n;
            }
        }
        System.out.println("입력");
        System.out.println("n = " + n);
        System.out.println("weak = " + Arrays.toString(newWeak));
        System.out.println("dist = " + Arrays.toString(dist));
        // 작업자 경우의 수 순열 리스트 생성
        ArrayList<int[]> permutations = new ArrayList<>();
        permutation(dist,  new int[dist.length], new boolean[dist.length], permutations, 0);
        System.out.println(" ");
        System.out.println("과정");
        System.out.println("permutations = " + Arrays.deepToString(permutations.toArray()));
        // 투입할 작업자 수의 최솟값을 찾아야 하므로 dist.length + 1로 하여 초기화
        int answer = dist.length + 1;
        // 0부터 length - 1 까지의 위치를 각각 시작점으로 설정
        for (int start = 0; start < length; start++) {
            // 작업자 모든 경우의 수 확인 (순열)
            for (int[] per : permutations) {
                int count = 1; // 투입할 작업자 수
                // 작업자가 점검할 수 있는 마지막 위치
                int position = newWeak[start] + per[count - 1];
                System.out.println("---");
                System.out.println("순열 = " + Arrays.toString(per));
                System.out.println("출발 취약 지점 = " + newWeak[start]);
                System.out.println("이동 거리 = " + per[count - 1]);
                System.out.println("취약 지점 + 이동 거리 = " + position);
                // 시작점 부터 모든 취약점 위치 확인
                for (int index = start; index < start + length; index++) {
                    // 점검할 수 있는 위치를 벗어나는 경우
                    if (position < newWeak[index]) {
                        count += 1; // 새로운 작업자 투입
                        if (count > dist.length) {
                            // 더 투입이 불가능 한 경우 종료
                            break;
                        }
                        position = newWeak[index] + per[count - 1];
                        System.out.println("취약 지점 = " + newWeak[index]);
                        System.out.println("이동 거리 = " + per[count - 1]);
                        System.out.println("취약 지점 + 이동 거리 = " + position);
                    }
                }
                answer = Math.min(answer, count); // 최소값 계산
                System.out.println("answer = " + answer);
            }
        }
        System.out.println(" ");
        System.out.println("출력");
        if (answer > dist.length) {
            return -1;
        } else {
            return answer;
        }
    }
    // 백트래킹 순열
    void permutation(int[] arr, int[] output, boolean[] visited, ArrayList<int[]> permutations, int depth){
        if (depth == arr.length) {
            permutations.add(output.clone());
            return;
        }
        for (int i = 0; i < arr.length; i++) {
            if (!visited[i]) {
                visited[i] = true;
                output[depth] = arr[i];
                permutation(arr, output, visited, permutations,depth + 1);
                visited[i] = false;
            }
        }
    }
}
/*
입력
n = 12
weak = [1, 3, 4, 9, 10, 13, 15, 16, 21, 22]
dist = [3, 5, 7]

과정
permutations = [[3, 5, 7], [3, 7, 5], [5, 3, 7], [5, 7, 3], [7, 3, 5], [7, 5, 3]]
---
순열 = [3, 5, 7]
출발 취약 지점 = 1
이동 거리 = 3
취약 지점 + 이동 거리 = 4
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동 거리 = 14
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 1
이동 거리 = 3
취약 지점 + 이동 거리 = 4
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 1
이동 거리 = 5
취약 지점 + 이동 거리 = 6
취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동 거리 = 12
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 1
이동 거리 = 5
취약 지점 + 이동 거리 = 6
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 1
이동 거리 = 7
취약 지점 + 이동 거리 = 8
취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동 거리 = 12
answer = 2
---
순열 = [7, 5, 3]
출발 취약 지점 = 1
이동 거리 = 7
취약 지점 + 이동 거리 = 8
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동 거리 = 14
answer = 2
---
순열 = [3, 5, 7]
출발 취약 지점 = 3
이동 거리 = 3
취약 지점 + 이동 거리 = 6
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동 거리 = 14
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 3
이동 거리 = 3
취약 지점 + 이동 거리 = 6
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 3
이동 거리 = 5
취약 지점 + 이동 거리 = 8
취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동 거리 = 12
취약 지점 = 13
이동 거리 = 7
취약 지점 + 이동 거리 = 20
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 3
이동 거리 = 5
취약 지점 + 이동 거리 = 8
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 3
이동 거리 = 7
취약 지점 + 이동 거리 = 10
취약 지점 = 13
이동 거리 = 3
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [7, 5, 3]
출발 취약 지점 = 3
이동 거리 = 7
취약 지점 + 이동 거리 = 10
취약 지점 = 13
이동 거리 = 5
취약 지점 + 이동 거리 = 18
answer = 2
---
순열 = [3, 5, 7]
출발 취약 지점 = 4
이동 거리 = 3
취약 지점 + 이동 거리 = 7
취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동 거리 = 14
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동 거리 = 22
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 4
이동 거리 = 3
취약 지점 + 이동 거리 = 7
취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 4
이동 거리 = 5
취약 지점 + 이동 거리 = 9
취약 지점 = 10
이동 거리 = 3
취약 지점 + 이동 거리 = 13
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동 거리 = 22
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 4
이동 거리 = 5
취약 지점 + 이동 거리 = 9
취약 지점 = 10
이동 거리 = 7
취약 지점 + 이동 거리 = 17
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 4
이동 거리 = 7
취약 지점 + 이동 거리 = 11
취약 지점 = 13
이동 거리 = 3
취약 지점 + 이동 거리 = 16
answer = 2
---
순열 = [7, 5, 3]
출발 취약 지점 = 4
이동 거리 = 7
취약 지점 + 이동 거리 = 11
취약 지점 = 13
이동 거리 = 5
취약 지점 + 이동 거리 = 18
answer = 2
---
순열 = [3, 5, 7]
출발 취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동 거리 = 12
취약 지점 = 13
이동 거리 = 5
취약 지점 + 이동 거리 = 18
answer = 2
---
순열 = [3, 7, 5]
출발 취약 지점 = 9
이동 거리 = 3
취약 지점 + 이동 거리 = 12
취약 지점 = 13
이동 거리 = 7
취약 지점 + 이동 거리 = 20
answer = 2
---
순열 = [5, 3, 7]
출발 취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동 거리 = 14
취약 지점 = 15
이동 거리 = 3
취약 지점 + 이동 거리 = 18
answer = 2
---
순열 = [5, 7, 3]
출발 취약 지점 = 9
이동 거리 = 5
취약 지점 + 이동 거리 = 14
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동 거리 = 22
answer = 2
---
순열 = [7, 3, 5]
출발 취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 1
---
순열 = [7, 5, 3]
출발 취약 지점 = 9
이동 거리 = 7
취약 지점 + 이동 거리 = 16
answer = 1
---
순열 = [3, 5, 7]
출발 취약 지점 = 10
이동 거리 = 3
취약 지점 + 이동 거리 = 13
취약 지점 = 15
이동 거리 = 5
취약 지점 + 이동 거리 = 20
취약 지점 = 21
이동 거리 = 7
취약 지점 + 이동 거리 = 28
answer = 1
---
순열 = [3, 7, 5]
출발 취약 지점 = 10
이동 거리 = 3
취약 지점 + 이동 거리 = 13
취약 지점 = 15
이동 거리 = 7
취약 지점 + 이동 거리 = 22
answer = 1
---
순열 = [5, 3, 7]
출발 취약 지점 = 10
이동 거리 = 5
취약 지점 + 이동 거리 = 15
취약 지점 = 16
이동 거리 = 3
취약 지점 + 이동 거리 = 19
취약 지점 = 21
이동 거리 = 7
취약 지점 + 이동 거리 = 28
answer = 1
---
순열 = [5, 7, 3]
출발 취약 지점 = 10
이동 거리 = 5
취약 지점 + 이동 거리 = 15
취약 지점 = 16
이동 거리 = 7
취약 지점 + 이동 거리 = 23
answer = 1
---
순열 = [7, 3, 5]
출발 취약 지점 = 10
이동 거리 = 7
취약 지점 + 이동 거리 = 17
취약 지점 = 21
이동 거리 = 3
취약 지점 + 이동 거리 = 24
answer = 1
---
순열 = [7, 5, 3]
출발 취약 지점 = 10
이동 거리 = 7
취약 지점 + 이동 거리 = 17
취약 지점 = 21
이동 거리 = 5
취약 지점 + 이동 거리 = 26
answer = 1

출력
1
*/