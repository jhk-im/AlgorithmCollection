import 'dart:io';

class Student {
  String? name;
  int count = 0;

  Student(String name, int count) {
    this.name = name;
    this.count = count;
  }
}

void main(List<String> arguments) {
  var input1 = stdin.readLineSync();
  if (input1 != null) {
    // n 입력 받기
    var n = int.parse(input1);

    var array = <Student>[];

    // 2차원 리스트 맵 정보 입력 받기
    for (int i = 0; i < n; i++) {
      var input2 = stdin.readLineSync()?.split(' ');
      if (input2 != null) {
        var student = Student(input2[0], int.parse(input2[1]));
        array.add(student);
      }
    }

    // 점수 기준으로 내림차순 정렬
    array.sort((a, b) => a.count.compareTo(b.count));

    for (Student student in array) {
      print('${student.name} '); // 정답 출력
    }
  }
}
/*
입력
2
김코딩 49
이자바 92

출력
김코딩
이자바 
*/