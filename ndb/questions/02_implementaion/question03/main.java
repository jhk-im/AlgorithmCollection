public class Main {
    static class Solution {
        public int solution(String s) {
            int answer = s.length();
            // step 1 부터 늘려가며 반복 확인 => 문자의 범위가 a, ab, abc 로 순차적으로 증가함
            for (int step = 1; step <= s.length() / 2; step++) {
                int length = 0;
                System.out.println("---");
                // step 크기만큼 증가시키며 확인
                for (int j = 0; j + step <= s.length();) {
                    int next = j + step;
                    int count = 1;
                    // 확인해 볼 문자열
                    String current = s.substring(j, next);
                    System.out.println("current -> " + current);

                    // 반복 문자 확인
                    while (next + step <= s.length() && current.equals(s.substring(next, next + step))) {
                        System.out.println("next -> " + s.substring(next, next + step));
                        next += step;
                        count++;
                    }

                    if (count == 1) {
                        // 반복되지 않은 경우 step 크기만 추가
                        length += step;
                    } else {
                        // 반복되는 경우 step + count 를 문자화 하여 문자 길이를 더함
                        length += step + String.valueOf(count).length();
                    }
                    j = next;
                    System.out.println("result -> " + length);
                }

                // 남아있는 문자의 길이 추가 -> 어차피 반복되지 않을 문자
                if (s.length() % step != 0) {
                    length += s.length() % step;
                    System.out.println("남아있는 문자열의 길이 -> " + s.length() % step);
                    System.out.println("result -> " + length);
                }
                answer = Math.min(answer, length);
            }
            return answer;
        }
    }

    public static void main(String[] args) {
        Solution solution = new Solution();
        System.out.println(solution.solution("aabbaccc"));
    }
}
/*
입력
aabbaccc

과정
current -> a
next -> a
result -> 2
current -> b
next -> b
result -> 4
current -> a
result -> 5
current -> c
next -> c
next -> c
result -> 7
---
current -> aa
result -> 2
current -> bb
result -> 4
current -> ac
result -> 6
current -> cc
result -> 8
---
current -> aab
result -> 3
current -> bac
result -> 6
남아있는 문자열의 길이 -> 2
result -> 8
---
current -> aabb
result -> 4
current -> accc
result -> 8

출력
7
*/