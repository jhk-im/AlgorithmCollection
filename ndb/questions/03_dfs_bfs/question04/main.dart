void main(List<String> arguments) {
  String ex = "";
  String ex1 = "(()())()";
  String ex2 = ")))(((";
  String ex3 = "()))((()";
  print(Solution().solution(ex3));
}

class Solution {
  String solution(String p) {
    print('입력 = $p');
    print(' ');
    print('과정');
    // 입력이 비어있는 문자열인 경우 빈 문자열 반환
    if (p.isEmpty) {
      print('p = empty');
      return p;
    }
    List<String> w = p.split("");
    // p -> 올바른 괄호 문자열 확인
    if (verification(w)) {
      print('p = true');
      return p;
    }
    // 재귀 함수 (DFS)
    String answer = dfs(w);
    print(' ');
    print('출력');
    return answer;
  }
  // 올바른 괄호 문자열 검증
  bool verification(List<String> list) {
    int count = 0; // 왼쪽 괄호 개수
    for (String p in list) {
      if (p == '(') {
        count += 1;
      } else {
        count -= 1;
        if (count < 0) return false;
      }
    }
    return true;
  }
  // 균형잡힌 문자열 인덱스 반환
  int balanced(List<String> list) {
    int count = 0; // 왼쪽 괄호 개수
    for (int i = 0; i < list.length; i++) {
      if (list[i] == '(') {
        count += 1;
      } else {
        count -= 1;
      }
      if (count == 0) return i + 1;
    }
    return 0;
  }
  // 괄호 변환 재귀 함수 (DFS)
  String dfs(List<String> w) {
    String answer = "";
    // 문자열 w를 u, v로 분리
    int index = balanced(w);
    if (index == 0) return answer;
    List<String> u = [];
    List<String> v = [];
    for (int i = 0; i < w.length; i++) {
      if (i < index) {
        u.add(w[i]);
      } else {
        v.add(w[i]);
      }
    }
    // 올바른 문자열인 경우
    if (verification(u)) {
      print('---depth1 verification(true)---');
      print('dfs(w) =  $w');
      print('u =  $u');
      print('v =  $v');
      print('call dfs(v)');
      answer += u.join() + dfs(v);
      print('---depth2 verification(true)---');
      print('u =  $u');
      print('v =  $v');
      print('answer = $answer');
    } else {
      print('---depth1 verification(false)---');
      print('dfs(w) =  $w');
      print('u =  $u');
      print('v =  $v');
      print('call dfs(v)');
      answer = "(";
      answer += dfs(v);
      answer += ")";
      u.removeAt(0);
      u.removeLast();
      for (int i = 0; i < u.length; i++) {
        if (u[i] == '(') {
          u[i] = ')';
        } else {
          u[i] = '(';
        }
      }
      answer += u.join();
      print('---depth2 verification(false)---');
      print('v =  $v');
      print('"(" + v + ")" = (${v.join()})');
      print('u =  $u');
      print('u -> first & last delete, middle turn = + ${u.join()}');
      print('answer = $answer');
    }
    return answer;
  }
}


/*
입력 = ()))((()

과정
---depth1 verification(true)---
dfs(w) =  [(, ), ), ), (, (, (, )]
u =  [(, )]
v =  [), ), (, (, (, )]
call dfs(v)
---depth1 verification(false)---
dfs(w) =  [), ), (, (, (, )]
u =  [), ), (, (]
v =  [(, )]
call dfs(v)
---depth1 verification(true)---
dfs(w) =  [(, )]
u =  [(, )]
v =  []
call dfs(v)
---depth2 verification(true)---
u =  [(, )]
v =  []
answer = ()
---depth2 verification(false)---
v =  [(, )]
"(" + v + ")" = (())
u =  [(, )]
u -> first & last delete, middle turn = ()
answer = (())()
---depth2 verification(true)---
u =  [(, )]
v =  [), ), (, (, (, )]
answer = ()(())()

출력
()(())()
*/