class Solution {
  int solution(List<int> foodTimes, double k) {
    List<Food> foods = <Food>[];
    // 음식의 총 개수
    int total = foodTimes.length;
    // List 추가
    for (int i = 0; i < total; i++) {
      // (음식 시간, 음식 번호)
      foods.add(Food(time: foodTimes[i], index: i + 1));
    }
    // 음식 시간기준 오름차순 정렬
    foods.sort((a, b) => a.time.compareTo(b.time));
    // 이전 시간
    int previousTime = 0;
    // 현재 인덱스
    int currentIndex = 0;
    for (Food food in foods) {
      // column 높이
      int diff = food.time - previousTime;
      print('diff = $diff');
      if (diff != 0) {
        // column.length * row.length
        int spend = diff * total;
        print('spend = $spend');
        if (spend <= k) {
          k -= spend;
          previousTime = food.time;
          print('k = $k');
          print('previousTime = $previousTime');
        } else {
          k %= total;
          foods
              .sublist(currentIndex, foods.length)
              .sort((a, b) => a.index.compareTo(b.index));
          print('---result---');
          print('k = $k');
          print('currentIndex = $currentIndex');
          // 다음 먹어야할 음식 연산
          return foods[currentIndex + k.toInt()].index;
        }
      }
      currentIndex++;
      total--;
    }
    return -1;
  }
}

class Food {
  final int time;
  final int index;

  Food({required this.time, required this.index});
}

void main(List<String> arguments) {
  Solution solution = Solution();
  print(solution.solution([3, 1, 2], 5));
}
/*
diff = 1
spend = 3
k = 2.0
previousTime = 1
diff = 1
spend = 2
k = 0.0
previousTime = 2
diff = 1
spend = 1
---result---
k = 0.0
currentIndex = 2
1
*/