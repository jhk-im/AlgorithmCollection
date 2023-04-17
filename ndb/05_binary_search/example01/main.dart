import 'dart:io';

void main(List<String> arguments) {
  print("생성할 원소 개수, 찾을 문자열 입력. ex)3 Kim");
  var input1 = stdin.readLineSync()?.split(' ');
  if (input1 != null) {
    // n, target 입력 받기
    var n = int.parse(input1[0]);
    var target = input1[1];

    print("원소 개수만큼 문자열 입력. ex)Lee Kim Park");
    var array = stdin.readLineSync()?.split(' ');
    if (array != null) {
      print(sequentialSearch(n, target, array));
    }
  }
}

int sequentialSearch(int n, String target, List<String> array) {
  // 각 원소 하나씩 확인
  for (int i = 0; i < n; i++) {
    if (array[i] == target) {
      return i + 1;
    }
  }
  return 0;
}
