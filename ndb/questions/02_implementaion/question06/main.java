import java.util.*;
public class Main {
    public static void main(String[] args) {
        Solution solution = new Solution();
        int[][] build_frame = {{0,0,0,1},{2,0,0,1},{4,0,0,1},{0,1,1,1},{1,1,1,1},{2,1,1,1},{3,1,1,1},{2,0,0,0},{1,1,1,0},{2,2,0,1}};
        System.out.println(Arrays.deepToString(solution.solution(5, build_frame)));
    }
}
class Solution {
    public int[][] solution(int n, int[][] build_frame) {
        List<List<Integer>> answerList = new ArrayList<>();
        System.out.println("---build frame---");
        System.out.println(Arrays.deepToString(build_frame));
        int count = 1;
        for (int[] frame : build_frame) {
            System.out.println("---build " + count + "---");
            count++;
            int x = frame[0];
            int y = frame[1];
            int stuff = frame[2];
            int operate = frame[3];
            System.out.println("좌표 = " + "(" + x + ", " + y + ")");
            System.out.println("작업물은 기둥 = " + (stuff == 0));
            System.out.println("작업물 추가 = " + (operate == 1));
            if (operate == 0) { // 작업물 삭제
                // 우선 삭제
                List<Integer> removeArray = Arrays.asList(x, y, stuff);
                answerList.remove(removeArray);
                // 삭제 가능한지 확인
                if (operatePossible(answerList)) {
                    // 불가능한 경우 다시 추가
                    answerList.add(removeArray);
                    System.out.println("delete not possible");
                } else {
                    System.out.println("delete possible");
                }
                System.out.println(Arrays.deepToString(answerList.toArray()));
            }
            if (operate == 1) { // 작업물 설치
                // 우선 설치
                List<Integer> addArray = Arrays.asList(x, y, stuff);
                answerList.add(addArray);
                // 설치 가능한지 확인
                if (operatePossible(answerList)) {
                    // 불가능한 경우 다시 삭제
                    answerList.remove(addArray);
                    System.out.println("add not possible");
                } else {
                    System.out.println("add possible");
                }
                System.out.println(Arrays.deepToString(answerList.toArray()));
            }
        }
        /*
        정렬기준
        1. x 기준으로 오름차순 정렬
        2. x 좌표가 같을경우 y좌표 기준으로 오름차순 정렬
        3. x, y 좌표가 모두 같을 경우 기둥이 보보다 먼저 오도록 정렬
        */
        System.out.println("---sort---");
        answerList.sort((o1, o2) -> {
            if (o1.get(0).equals(o2.get(0))) {
                if (o1.get(1).equals(o2.get(1))) {
                    if (o1.get(2) > o2.get(2)) {
                        return 1;
                    } else {
                        return -1;
                    }
                } else if (o1.get(1) > o2.get(1)) {
                    return 1;
                } else {
                    return -1;
                }
            } else if (o1.get(0) > o2.get(0)) {
                return 1;
            } else {
                return -1;
            }
        });

        int[][] answer = new int[answerList.size()][3];

        for (int i = 0; i < answerList.size(); i++) {
            answer[i] = answerList.get(i).stream().mapToInt((a -> a)).toArray();
        }
        return answer;
    }

    boolean operatePossible(List<List<Integer>> answer) {
        for (List<Integer> array : answer) {
            System.out.println("possible()");
            int x = array.get(0);
            int y = array.get(1);
            int stuff = array.get(2);
            if (stuff == 0) { // 기둥인 경우
                boolean isOnFloor = y == 0; // 바닥 위인지 판별
                List<Integer> pilar = Arrays.asList(x, y - 1, 0); // 다른 기둥의 위인지 판별
                // 보의 한쪽 끝부분 위인지 판별을 위함
                List<Integer> beam1 = Arrays.asList(x - 1, y, 1);
                List<Integer> beam2 = Arrays.asList(x, y, 1);
                System.out.println("기둥");
                System.out.println("isOnFloor -> " + isOnFloor);
                System.out.println("pilar -> " + pilar);
                System.out.println("beam 1 -> " + beam1);
                System.out.println("beam 2 -> " + beam2);
                if (isOnFloor || answer.contains(pilar) || answer.contains(beam1) || answer.contains(beam2)) {
                    continue;
                }
                return true;
            } else if (stuff == 1)  { // 보인 경우
                // 한쪽 끝부분이 기둥 위인지 판별을 위함
                List<Integer> pilar1 = Arrays.asList(x, y - 1, 0);
                List<Integer> pilar2 = Arrays.asList(x + 1, y - 1, 0);
                // 양쪽 끝 부분이 보와 연결 되었는지 판별하기 위함
                List<Integer> beam1 = Arrays.asList(x - 1, y, 1);
                List<Integer> beam2 = Arrays.asList(x + 1, y, 1);
                System.out.println("보");
                System.out.println("pilar1 -> " + pilar1);
                System.out.println("pilar2 -> " + pilar2);
                System.out.println("beam 1 -> " + beam1);
                System.out.println("beam 2 -> " + beam2);
                if (answer.contains(pilar1) || answer.contains(pilar2) || answer.contains(beam1) && answer.contains(beam2)) {
                    continue;
                }
                return true;
            }
        }
        return false;
    }
}
/*
입력
n = 5
build_frame = [[0,0,0,1],[2,0,0,1],[4,0,0,1],[0,1,1,1],[1,1,1,1],[2,1,1,1],[3,1,1,1],[2,0,0,0],[1,1,1,0],[2,2,0,1]]

과정
---build frame---
[[0, 0, 0, 1], [2, 0, 0, 1], [4, 0, 0, 1], [0, 1, 1, 1], [1, 1, 1, 1], [2, 1, 1, 1], [3, 1, 1, 1], [2, 0, 0, 0], [1, 1, 1, 0], [2, 2, 0, 1]]
---build 1---
좌표 = (0, 0)
작업물은 기둥 = true
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
add possible
[[0, 0, 0]]
---build 2---
좌표 = (2, 0)
작업물은 기둥 = true
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam 1 -> [1, 0, 1]
beam 2 -> [2, 0, 1]
add possible
[[0, 0, 0], [2, 0, 0]]
---build 3---
좌표 = (4, 0)
작업물은 기둥 = true
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam 1 -> [1, 0, 1]
beam 2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0]]
---build 4---
좌표 = (0, 1)
작업물은 기둥 = false
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam 1 -> [1, 0, 1]
beam 2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1]]
---build 5---
좌표 = (1, 1)
작업물은 기둥 = false
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam 1 -> [1, 0, 1]
beam 2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam 1 -> [0, 1, 1]
beam 2 -> [2, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1]]
---build 6---
좌표 = (2, 1)
작업물은 기둥 = false
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam 1 -> [1, 0, 1]
beam 2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam 1 -> [0, 1, 1]
beam 2 -> [2, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam 1 -> [1, 1, 1]
beam 2 -> [3, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1]]
---build 7---
좌표 = (3, 1)
작업물은 기둥 = false
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [2, -1, 0]
beam 1 -> [1, 0, 1]
beam 2 -> [2, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam 1 -> [0, 1, 1]
beam 2 -> [2, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam 1 -> [1, 1, 1]
beam 2 -> [3, 1, 1]
possible()
보
pilar1 -> [3, 0, 0]
pilar2 -> [4, 0, 0]
beam 1 -> [2, 1, 1]
beam 2 -> [4, 1, 1]
add possible
[[0, 0, 0], [2, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1]]
---build 8---
좌표 = (2, 0)
작업물은 기둥 = true
작업물 추가 = false
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam 1 -> [0, 1, 1]
beam 2 -> [2, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam 1 -> [1, 1, 1]
beam 2 -> [3, 1, 1]
possible()
보
pilar1 -> [3, 0, 0]
pilar2 -> [4, 0, 0]
beam 1 -> [2, 1, 1]
beam 2 -> [4, 1, 1]
delete possible
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1]]
---build 9---
좌표 = (1, 1)
작업물은 기둥 = false
작업물 추가 = false
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam 1 -> [1, 1, 1]
beam 2 -> [3, 1, 1]
delete not possible
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [2, 1, 1], [3, 1, 1], [1, 1, 1]]
---build 10---
좌표 = (2, 2)
작업물은 기둥 = true
작업물 추가 = true
possible()
기둥
isOnFloor -> true
pilar -> [0, -1, 0]
beam 1 -> [-1, 0, 1]
beam 2 -> [0, 0, 1]
possible()
기둥
isOnFloor -> true
pilar -> [4, -1, 0]
beam 1 -> [3, 0, 1]
beam 2 -> [4, 0, 1]
possible()
보
pilar1 -> [0, 0, 0]
pilar2 -> [1, 0, 0]
beam 1 -> [-1, 1, 1]
beam 2 -> [1, 1, 1]
possible()
보
pilar1 -> [2, 0, 0]
pilar2 -> [3, 0, 0]
beam 1 -> [1, 1, 1]
beam 2 -> [3, 1, 1]
possible()
보
pilar1 -> [3, 0, 0]
pilar2 -> [4, 0, 0]
beam 1 -> [2, 1, 1]
beam 2 -> [4, 1, 1]
possible()
보
pilar1 -> [1, 0, 0]
pilar2 -> [2, 0, 0]
beam 1 -> [0, 1, 1]
beam 2 -> [2, 1, 1]
possible()
기둥
isOnFloor -> false
pilar -> [2, 1, 0]
beam 1 -> [1, 2, 1]
beam 2 -> [2, 2, 1]
add not possible
[[0, 0, 0], [4, 0, 0], [0, 1, 1], [2, 1, 1], [3, 1, 1], [1, 1, 1]]
---sort---

결과
[[0, 0, 0], [0, 1, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1], [4, 0, 0]]
*/
