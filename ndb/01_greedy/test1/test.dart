import 'dart:io';

void main(List<String> arguments) {
  List<String>? input1 = stdin.readLineSync()?.split(" ");

  if (input1 != null) {
    // N, M, K를 공백으로 구분하여 입력받음
    final N = int.parse(input1[0]);
    //print("$N");
    var M = int.parse(input1[1]);
    //print("$M");
    final K = int.parse(input1[2]);
    //print("$K");

    // N개의 수를 공백으로 구분하여 입력받음
    List<String>? input2 = stdin.readLineSync()?.split(" ");
    final data = input2?.map(int.parse).toList();
    //print("$data");

    if (data != null) {
      data.sort(); // 입력받은 수 정렬
      final first = data[N - 1]; // 가장 큰 수
      final second = data[N - 2]; // 두 번째로 큰 수

      var result = 0;

      /*
      - M이 10,000 이하인 경우 아래 방식으로 문제 해결 가능
      - M의 크기가 100억 이상으로 커지는 경우 시간 초과 발생
      while (true) {
        for (int i = 0; i < K; i++) { // 가장 큰 수를 K번 더하기
          if (M == 0) {
            break;
          }
          result += first;
          M -= 1;
        }

        if (M == 0) {
          break;
        }
        result += second; // 두 번째로 큰 수를 한 번 더하기
        M -= 1;
      }
      */

      // 가장 큰 수가 더해지는 횟수 계산
      var count = (M / (K + 1) * K).toInt();
      count += M % (K + 1);

      result += (count * first); // 가장 큰 수 더하기
      result += (M - count) * second; // 두 번째로 큰 수 더하기

      print(result); // 최종 답안 출력
    }
  }
}
