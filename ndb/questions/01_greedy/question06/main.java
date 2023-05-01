import java.util.*;

/**
 *  해당 방식으로는 효율성 테스트 통과 못함
 *  우선순위 큐 이해하는 정도로 마무리
 */

public class Main {

    static class Solution {
        public int solution(int[] food_times, long k) {
            System.out.println("음식 리스트 = " + Arrays.toString(food_times));
            // 모든 음식을 먹는데 필요한 시간
            long total = 0;
            // 우선순위 큐 최소힙 사용
            PriorityQueue<CustomEntry> priorityQueue = new PriorityQueue<>();
            for (int i = 0; i < food_times.length; i++) {
                total += food_times[i];
                // 음식 시간, 음식 번호
                priorityQueue.offer(new CustomEntry(food_times[i], i + 1));
            }
            // 전체 음식을 먹는 시간보다 k가 크거나 같다면
            if (total <= k) return -1;
            int sumValue = 0; // 먹기 위해 사용한 시간
            int previous = 0; // 직전에 다 먹은 음식 시간
            int length = food_times.length; // 남은 음식의 개수
            // (사용한 시간 + (현재 음식 시간 - 이전 음식 시간 ) * 남은 음식의 개수)
            while (sumValue + ((priorityQueue.peek().getTime() - previous) * length) <= k) {
                // 시간이 가장 작은 음식 꺼내기
                CustomEntry poll = priorityQueue.poll();
                if (poll != null) {
                    int now = poll.getTime(); // 확인할 음식 시간
                    System.out.println("---");
                    System.out.println("(음식시간, 음식번호)");
                    System.out.println("(" + poll.getTime() + "," + poll.getIndex() + ")");
                    System.out.println("previous(이전 음식) = " + previous);
                    sumValue += (now - previous) * length;
                    length -= 1; // 다 먹은 음식 제외
                    previous = now; // 이전 음식 시간 재설정
                    System.out.println("now(확인 할 음식 시간) = " + now);
                    System.out.println("sumValue(먹기위해 사용한 시간) = " + sumValue);
                    System.out.println("length(남은 음식의 개수) = " + length);
                }
            }
            // 음식 번호대로 정렬하기 위한 ArrayList
            ArrayList<CustomEntry> result = new ArrayList<>();
            while (!priorityQueue.isEmpty()) {
                result.add(priorityQueue.poll());
            }
            result.sort(Comparator.comparingInt(CustomEntry::getIndex));
            return result.get((int) (k - sumValue) % length).getIndex();
        }

        static class CustomEntry implements Comparable<CustomEntry> {
            private int time;
            private int index;

            public CustomEntry(int time, int index) {
                this.time =time;
                this.index = index;
            }

            public int getTime() {
                return this.time;
            }

            public int getIndex() {
                return this.index;
            }

            @Override
            public int compareTo(CustomEntry other) {
                if(this.time < other.time)
                    return -1;
                else
                    return 1;
            }
        }
    }

    public static void main(String[] args) {
        Solution solution = new Solution();
        int[] array = {3, 1, 2};
        System.out.println(solution.solution(array, 5));
    }
}

/*
음식 리스트 = [3, 1, 2]
---
(음식시간, 음식번호)
(1,2)
previous(이전 음식) = 0
now(확인 할 음식 시간) = 1
sumValue(먹기위해 사용한 시간) = 3
length(남은 음식의 개수) = 2
---
(음식시간, 음식번호)
(2,3)
previous(이전 음식) = 1
now(확인 할 음식 시간) = 2
sumValue(먹기위해 사용한 시간) = 5
length(남은 음식의 개수) = 1
1
*/