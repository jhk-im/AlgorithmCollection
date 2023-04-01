import 'dart:io';

void main(List<String> arguments) {
  List<String>? input1 = stdin.readLineSync()?.split(" ");

  if (input1 != null) {
    final N = int.parse(input1[0]);
    //print("$N");
    var M = int.parse(input1[1]);
    //print("$M");
    final K = int.parse(input1[2]);
    //print("$K");

    List<String>? input2 = stdin.readLineSync()?.split(" ");
    final data = input2?.map(int.parse).toList();
    //print("$data");

    if (data != null) {
      data.sort();
      final first = data[N - 1];
      final second = data[N - 2];

      var result = 0;

      while (true) {
        for (int i = 0; i < K; i++) {
          if (M == 0) {
            break;
          }
          result += first;
          M -= 1;
        }

        if (M == 0) {
          break;
        }
        result += second;
        M -= 1;
      }

      print(result);
    }
  }
}
