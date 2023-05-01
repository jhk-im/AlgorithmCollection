import 'package:collection/collection.dart';

///  해당 방식으로는 효율성 테스트 통과 못함
///  우선순위 큐 이해하는 정도로 마무리

class Solution {
  int solution(List<int> foodTimes, double k) {
    print('음식 리스트 = $foodTimes');
    // 모든 음식을 먹는데 필요한 시간
    double total = 0;
    // 우선순위 큐 최소힙 사용
    PriorityQueue<CustomEntry> priorityQueue =
        PriorityQueue<CustomEntry>((a, b) => a.time.compareTo(b.time));
    for (int i = 0; i < foodTimes.length; i++) {
      total += foodTimes[i];
      // 음식 시간, 음식 번호
      priorityQueue.add(CustomEntry(time: foodTimes[i], index: i + 1));
    }
    // 전체 음식을 먹는 시간보다 k가 크거나 같다면
    if (total <= k) return -1;
    int sumValue = 0; // 먹기 위해 사용한 시간
    int previous = 0; // 직전에 다 먹은 음식 시간
    int length = foodTimes.length; // 남은 음식의 개수
    while (sumValue + ((priorityQueue.first.time - previous) * length) <= k) {
      // 시간이 가장 작은 음식 꺼내기
      CustomEntry first = priorityQueue.removeFirst(); // 확인할 음식 시간
      int now = first.time;
      int index = first.index;
      print('---');
      print('(음식시간, 음식번호)');
      print('($now, $index)');
      sumValue += (now - previous) * length;
      length -= 1; // 다 먹은 음식 제외
      previous = now; // 이전 음식 시간 재설정
      print('now(확인 할 음식 시간) = $now');
      print('sumValue(먹기위해 사용한 시간) = $sumValue');
      print('length(남은 음식의 개수) = $length');
    }

    List<CustomEntry> result = [];
    while (priorityQueue.isNotEmpty) {
      result.add(priorityQueue.removeFirst());
    }

    result.sort((a, b) => a.index.compareTo(b.index));

    double idx = ((k - sumValue) % length);

    return result[idx.toInt()].index;
  }
}

class CustomEntry {
  final int time;
  final int index;

  CustomEntry({required this.time, required this.index});
}

void main(List<String> arguments) {
  Solution solution = Solution();
  print(solution.solution([3, 1, 2], 5));
}
/*
음식 리스트 = [3, 1, 2]
object
3
---
(음식시간, 음식번호)
(1, 2)
now(확인 할 음식 시간) = 1
sumValue(먹기위해 사용한 시간) = 3
length(남은 음식의 개수) = 2
---
(음식시간, 음식번호)
(2, 3)
now(확인 할 음식 시간) = 2
sumValue(먹기위해 사용한 시간) = 5
length(남은 음식의 개수) = 1
1
*/