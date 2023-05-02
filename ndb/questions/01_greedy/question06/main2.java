import java.util.*;

public class Main {

    static class Solution {

        public int solution(int[] food_times, long k) {
            List<Food> foods = new LinkedList<>();
            // 음식의 총 개수
            int total = food_times.length;
            // LinkedList 에 추가
            for (int i = 0; i < total; i++){
                // (음식 시간, 음식 번호)
                foods.add(new Food(food_times[i], i + 1));
            }
            // 음식 시간기준 오름차순 정렬
            foods.sort(Comparator.comparingInt(o -> o.time));
            // 이전 시간
            int previousTime = 0;
            // 현재 인덱스
            int currentIndex = 0;
            for (Food f : foods) {
                // column 의 높이
                long diff = f.time - previousTime;
                System.out.println("diff = " + diff);
                if (diff != 0) {
                    // column.length * row.length
                    long spend = diff * total;
                    System.out.println("spend = " + spend);
                    if (spend <= k) {
                        k -= spend;
                        previousTime = f.time;
                        System.out.println("k = " + k);
                        System.out.println("previousTime = " + previousTime);
                    } else {
                        // 남은 음식 index 기준 재정렬
                        k %= total;
                        foods.subList(currentIndex, foods.size()).sort(Comparator.comparingInt(o -> o.index));
                        System.out.println("---result---");
                        System.out.println("k = " + k);
                        System.out.println("currentIndex = " + currentIndex);
                        // 다음 먹어야할 음식 연산
                        return foods.get(currentIndex + (int) k).index;
                    }
                }
                currentIndex++;
                total--;
            }

            return -1;
        }

        static class Food {
            int time;
            int index;

            public Food(int time, int index) {
                this.time = time;
                this.index = index;
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
diff = 1
spend = 3
k = 2
previousTime = 1
diff = 1
spend = 2
k = 0
previousTime = 2
diff = 1
spend = 1
---result---
k = 0
currentIndex = 2
1
*/