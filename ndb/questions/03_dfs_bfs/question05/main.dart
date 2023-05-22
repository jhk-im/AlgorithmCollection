import 'dart:io';
import 'dart:math';

// 최솟값 최댓값 초기화
int minValue = 1000000000;
int maxValue = -1000000000;
List<int> data = [];

void main(List<String> arguments) {
  print('입력');
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    // n 입력 받기
    int n = int.parse(input1);
    // 연산을 실행하고자 하는 수 리스트 입력받기
    var input2 = stdin.readLineSync()?.split(" ");
    if (input2 != null) {
      data = input2.map(int.parse).toList();
      // 더하기, 빼기, 곱하기, 나누기 연산자 개수 입력받기
      List<String> operator = [ '+', '-', '*', '/' ];
      var input3 = stdin.readLineSync()?.split(" ");
      if (input3 != null) {
        List<int> inputs = input3.map(int.parse).toList();
        List<String> operators = [];
        for (int i = 0; i < inputs.length; i++) {
          for (int j = 0; j < inputs[i]; j++) {
            operators.add(operator[i]);
          }
        }
        print(' ');
        print('과정');
        print('data = $data');
        print('operators = $operators');
        print('---permutation()---');
        permutation(
            operators,
            List.filled(operators.length, ''),
            List.filled(operators.length, false), 0);
        print(' ');
        print('출력');
        print(maxValue);
        print(minValue);
      }
    }
  }
}

// 백트래킹 순열
void permutation(List<String> arr, List<String> output, List<bool> visited, int depth) {
  if (depth == arr.length) {
    print('permutations = $output');
    print('data = $data');
    // 순열 리스트 모든 경우의 수 연산 수행
    int value = data[0];
    for (int i = 0; i < output.length; i++) {
      int next = data[i + 1];
      switch (output[i]) {
        case "+":
          value = value + next;
          break;
        case "-":
          value = value - next;
          break;
        case "*":
          value = value * next;
          break;
        case "/":
          value = value ~/ next;
          break;
      }
    }
    print("value = $value");
    maxValue = max(maxValue, value);
    minValue = min(minValue, value);
    return;
  }
  for (int i = 0; i < arr.length; i++) {
    if (!visited[i]) {
      visited[i] = true;
      output[depth] = arr[i];
      permutation(arr, output, visited, depth + 1);
      visited[i] = false;
    }
  }
}
/*
입력
6
1 2 3 4 5 6
2 1 1 1
 
과정
data = [1, 2, 3, 4, 5, 6]
operators = [+, +, -, *, /]
---permutation()---
permutations = [+, +, -, *, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, +, -, /, *]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, +, *, -, /]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, +, *, /, -]
data = [1, 2, 3, 4, 5, 6]
value = -2
permutations = [+, +, /, -, *]
data = [1, 2, 3, 4, 5, 6]
value = -24
permutations = [+, +, /, *, -]
data = [1, 2, 3, 4, 5, 6]
value = -1
permutations = [+, -, +, *, /]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, -, +, /, *]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, -, *, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, -, *, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [+, -, /, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 30
permutations = [+, -, /, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [+, *, +, -, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, *, +, /, -]
data = [1, 2, 3, 4, 5, 6]
value = -4
permutations = [+, *, -, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, *, -, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [+, *, /, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, *, /, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, /, +, -, *]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, /, +, *, -]
data = [1, 2, 3, 4, 5, 6]
value = 19
permutations = [+, /, -, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 12
permutations = [+, /, -, *, +]
data = [1, 2, 3, 4, 5, 6]
value = -9
permutations = [+, /, *, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, /, *, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [+, +, -, *, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, +, -, /, *]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, +, *, -, /]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, +, *, /, -]
data = [1, 2, 3, 4, 5, 6]
value = -2
permutations = [+, +, /, -, *]
data = [1, 2, 3, 4, 5, 6]
value = -24
permutations = [+, +, /, *, -]
data = [1, 2, 3, 4, 5, 6]
value = -1
permutations = [+, -, +, *, /]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, -, +, /, *]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, -, *, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, -, *, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [+, -, /, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 30
permutations = [+, -, /, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [+, *, +, -, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, *, +, /, -]
data = [1, 2, 3, 4, 5, 6]
value = -4
permutations = [+, *, -, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, *, -, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [+, *, /, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [+, *, /, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, /, +, -, *]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [+, /, +, *, -]
data = [1, 2, 3, 4, 5, 6]
value = 19
permutations = [+, /, -, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 12
permutations = [+, /, -, *, +]
data = [1, 2, 3, 4, 5, 6]
value = -9
permutations = [+, /, *, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [+, /, *, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [-, +, +, *, /]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [-, +, +, /, *]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [-, +, *, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 2
permutations = [-, +, *, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [-, +, /, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 30
permutations = [-, +, /, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [-, +, +, *, /]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [-, +, +, /, *]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [-, +, *, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 2
permutations = [-, +, *, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [-, +, /, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 30
permutations = [-, +, /, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [-, *, +, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [-, *, +, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [-, *, +, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [-, *, +, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [-, *, /, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [-, *, /, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [-, /, +, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 54
permutations = [-, /, +, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 26
permutations = [-, /, +, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 54
permutations = [-, /, +, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 26
permutations = [-, /, *, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [-, /, *, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [*, +, +, -, /]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [*, +, +, /, -]
data = [1, 2, 3, 4, 5, 6]
value = -5
permutations = [*, +, -, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [*, +, -, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [*, +, /, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [*, +, /, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 2
permutations = [*, +, +, -, /]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [*, +, +, /, -]
data = [1, 2, 3, 4, 5, 6]
value = -5
permutations = [*, +, -, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [*, +, -, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [*, +, /, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 0
permutations = [*, +, /, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 2
permutations = [*, -, +, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [*, -, +, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [*, -, +, +, /]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [*, -, +, /, +]
data = [1, 2, 3, 4, 5, 6]
value = 6
permutations = [*, -, /, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [*, -, /, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [*, /, +, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [*, /, +, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [*, /, +, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [*, /, +, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [*, /, -, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [*, /, -, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [/, +, +, -, *]
data = [1, 2, 3, 4, 5, 6]
value = 12
permutations = [/, +, +, *, -]
data = [1, 2, 3, 4, 5, 6]
value = 29
permutations = [/, +, -, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 24
permutations = [/, +, -, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [/, +, *, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [/, +, *, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 13
permutations = [/, +, +, -, *]
data = [1, 2, 3, 4, 5, 6]
value = 12
permutations = [/, +, +, *, -]
data = [1, 2, 3, 4, 5, 6]
value = 29
permutations = [/, +, -, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 24
permutations = [/, +, -, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 1
permutations = [/, +, *, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [/, +, *, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 13
permutations = [/, -, +, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 36
permutations = [/, -, +, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [/, -, +, +, *]
data = [1, 2, 3, 4, 5, 6]
value = 36
permutations = [/, -, +, *, +]
data = [1, 2, 3, 4, 5, 6]
value = 11
permutations = [/, -, *, +, +]
data = [1, 2, 3, 4, 5, 6]
value = -1
permutations = [/, -, *, +, +]
data = [1, 2, 3, 4, 5, 6]
value = -1
permutations = [/, *, +, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [/, *, +, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [/, *, +, +, -]
data = [1, 2, 3, 4, 5, 6]
value = 3
permutations = [/, *, +, -, +]
data = [1, 2, 3, 4, 5, 6]
value = 5
permutations = [/, *, -, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
permutations = [/, *, -, +, +]
data = [1, 2, 3, 4, 5, 6]
value = 7
 
출력
54
-24
*/