import java.util.*;

public class Main {
    public static void main(String[] args) {
        String ex = "";
        String ex1 = "(()())()";
        String ex2 = ")))(((";
        String ex3 = "()))((()";
        System.out.println(new Solution().solution(ex3));
    }
}

class Solution {
    public String solution(String p) {
        System.out.println("입력 = " + p);
        System.out.println(" ");
        System.out.println("과정");
        // 입력이 비어있는 문자열인 경우 빈 문자열 반환
        if (p.isEmpty()) {
            System.out.println("p = empty");
            return p;
        }
        char[] pArray = p.toCharArray();
        // p -> 올바른 괄호 문자열 확인
        if (verification(pArray)) {
            System.out.println("p = true");
            return p;
        }
        // 재귀 함수 (DFS)
        String answer = dfs(pArray);
        System.out.println(" ");
        System.out.println("출력");
        return answer;
    }
    // 올바른 괄호 문자열 검증
    boolean verification(char[] array) {
        int count = 0; // 왼쪽 괄호 개수
        for (char p : array) {
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
    int balanced(char[] array) {
        int count = 0; // 왼쪽 괄호 개수
        for (int i = 0; i < array.length; i++) {
            if (array[i] == '(') {
                count += 1;
            } else {
                count -= 1;
            }
            if (count == 0) return i + 1;
        }
        return 0;
    }
    // 괄호 변환 재귀 함수 (DFS)
    String dfs(char[] wArray) {
        // 문자열 w를 u, v로 분리
        String answer = "";
        int index = balanced(wArray);
        if (index == 0) return answer;
        char[] uArray = new char[index]; // 균형잡힌 괄호 문자열, 더 이상 분리 할 수 없어야함
        char[] vArray = new char[wArray.length - index]; // 빈 문자열이 될 수 있음
        for (int i = 0; i < wArray.length; i++) {
            if (i < index) {
                uArray[i] = wArray[i];
            } else {
                vArray[i - index] = wArray[i];
            }
        }
        // 올바른 문자열인 경우
        if (verification(uArray)) {
            System.out.println("---depth1 verification(true)---");
            System.out.println("dfs(wArray) = " + Arrays.toString(wArray));
            System.out.println("uArray = " + Arrays.toString(uArray));
            System.out.println("vArray = " + Arrays.toString(vArray));
            System.out.println("call dfs(vArray)");
            answer += new String(uArray) + dfs(vArray);
            System.out.println("---depth2 verification(true)---");
            System.out.println("uArray = " + Arrays.toString(uArray));
            System.out.println("vArray = " + Arrays.toString(vArray));
            System.out.println("verification(true) answer = " + answer);
        } else {
            System.out.println("---depth1 verification(false)---");
            System.out.println("dfs(wArray) = " + Arrays.toString(wArray));
            System.out.println("uArray = " + Arrays.toString(uArray));
            System.out.println("vArray = " + Arrays.toString(vArray));
            System.out.println("call dfs(vArray)");
            answer = "(";
            answer += dfs(vArray);
            answer += ")";
            char[] u = new char[uArray.length - 2];
            for (int i = 0; i < uArray.length; i++) {
                if (i > 0 && i < uArray.length - 1) {
                    if (uArray[i] == '(') {
                        u[i - 1] = ')';
                    } else {
                        u[i - 1] = '(';
                    }
                }
            }
            answer += new String(u);
            System.out.println("---depth2 verification(false)---");
            System.out.println("vArray = " + Arrays.toString(vArray));
            System.out.println("\"(\" + vArray + \")\" = " + "(" + new String(vArray) + ")");
            System.out.println("uArray = " + Arrays.toString(uArray));
            System.out.println("uArray -> first & last delete, middle turn = " + new String(u));
            System.out.println("verification(false) answer = " + answer);
        }
        return answer;
    }
}
/*
입력 = ()))((()
 
과정
---depth1 verification(true)---
dfs(wArray) = [(, ), ), ), (, (, (, )]
uArray = [(, )]
vArray = [), ), (, (, (, )]
call dfs(vArray)
---depth1 verification(false)---
dfs(wArray) = [), ), (, (, (, )]
uArray = [), ), (, (]
vArray = [(, )]
call dfs(vArray)
---depth1 verification(true)---
dfs(wArray) = [(, )]
uArray = [(, )]
vArray = []
call dfs(vArray)
---depth2 verification(true)---
uArray = [(, )]
vArray = []
verification(true) answer = ()
---depth2 verification(false)---
vArray = [(, )]
"(" + vArray + ")" = (())
uArray = [), ), (, (]
uArray -> first & last delete, middle turn = ()
verification(false) answer = (())()
---depth2 verification(true)---
uArray = [(, )]
vArray = [), ), (, (, (, )]
verification(true) answer = ()(())()
 
출력
()(())()
*/
