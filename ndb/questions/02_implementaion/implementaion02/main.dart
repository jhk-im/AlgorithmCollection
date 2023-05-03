import 'dart:io';

void main(List<String> arguments) {
  // 문자열 s 입력받음
  List<String>? s = stdin.readLineSync()?.split("");
  if (s != null) {
    // 문자열 리스트 오름차순 정렬
    s.sort();
    print('sort -> $s');
    // 숫자와 문자 판별
    int sum = 0;
    StringBuffer text = StringBuffer();
    RegExp re = RegExp(r'^[0-9]+$');
    for (String value in s) {
      if (re.hasMatch(value)) {
        // 숫자 판별
        print('sum += $value');
        sum += int.parse(value);
      } else {
        print('text += $value');
        text.write(value);
      }
    }
    // 결과 출력
    print('${text.toString()}$sum');
  }
}
/*
입력
K1KA5CB7

과정
sort -> [1, 5, 7, A, B, C, K, K]
sum += 1
sum += 5
sum += 7
text += A
text += B
text += C
text += K
text += K

출력
ABCKK13
*/