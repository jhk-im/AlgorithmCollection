import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    // 최솟값 최댓값 초기화
    static int minValue = 1000000000;
    static int maxValue = -1000000000;
    public static void main(String[] args) {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            System.out.println("입력");
            // n 입력 받기
            String input1 = br.readLine();
            int n = Integer.parseInt(input1);
            // 연산을 실행하고자 하는 수 리스트 입력받기
            String[] input2 = br.readLine().split(" ");
            int[] data = Arrays.stream(input2).mapToInt(Integer::parseInt).toArray();
            // 더하기, 빼기, 곱하기, 나누기 연산자 개수 입력받기
            String[] operator = { "+", "-", "*", "/" };
            int[] inputs = Arrays.stream(br.readLine().split(" ")).mapToInt(Integer::parseInt).toArray();
            String[] operators = new String[Arrays.stream(inputs).sum()];
            int index = 0;
            for (int i = 0; i < inputs.length; i++) {
                for (int j = 0; j < inputs[i]; j++) {
                    operators[index] = operator[i];
                    index++;
                }
            }
            System.out.println(" ");
            System.out.println("과정");
            System.out.println("data = " + Arrays.toString(data));
            System.out.println("operators = " + Arrays.toString(operators));
            System.out.println("---permutation()---");
            permutation(operators, new String[operators.length], new boolean[operators.length], data, 0);
            System.out.println(" ");
            System.out.println("출력");
            System.out.println(maxValue);
            System.out.println(minValue);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // 백트래킹 중복 순열
    static void permutation(String[] arr, String[] output, boolean[] visited, int[] data, int depth){
        if (depth == arr.length) {
            System.out.println("permutations = " + Arrays.toString(output));
            // 순열 리스트 완전 탐색하여 연산 수행
            int value = data[0];
            System.out.print(value);
            for (int i = 0; i < output.length; i++) {
                System.out.print(output[i]);
                System.out.print(data[i + 1]);
                int next = data[i + 1];
                switch (output[i]) {
                    case "+" -> value = value + next;
                    case "-" -> value = value - next;
                    case "*" -> value = value * next;
                    case "/" -> value = value / next;
                }
            }
            System.out.println(" = " + value);
            maxValue = Math.max(maxValue, value);
            minValue = Math.min(minValue, value);
            return;
        }
        for (int i = 0; i < arr.length; i++) {
            if (!visited[i]) {
                visited[i] = true;
                output[depth] = arr[i];
                permutation(arr, output, visited, data,depth + 1);
                visited[i] = false;
            }
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
1+2+3-4*5/6 = 1
permutations = [+, +, -, /, *]
1+2+3-4/5*6 = 0
permutations = [+, +, *, -, /]
1+2+3*4-5/6 = 3
permutations = [+, +, *, /, -]
1+2+3*4/5-6 = -2
permutations = [+, +, /, -, *]
1+2+3/4-5*6 = -24
permutations = [+, +, /, *, -]
1+2+3/4*5-6 = -1
permutations = [+, -, +, *, /]
1+2-3+4*5/6 = 3
permutations = [+, -, +, /, *]
1+2-3+4/5*6 = 0
permutations = [+, -, *, +, /]
1+2-3*4+5/6 = 0
permutations = [+, -, *, /, +]
1+2-3*4/5+6 = 6
permutations = [+, -, /, +, *]
1+2-3/4+5*6 = 30
permutations = [+, -, /, *, +]
1+2-3/4*5+6 = 6
permutations = [+, *, +, -, /]
1+2*3+4-5/6 = 1
permutations = [+, *, +, /, -]
1+2*3+4/5-6 = -4
permutations = [+, *, -, +, /]
1+2*3-4+5/6 = 1
permutations = [+, *, -, /, +]
1+2*3-4/5+6 = 7
permutations = [+, *, /, +, -]
1+2*3/4+5-6 = 1
permutations = [+, *, /, -, +]
1+2*3/4-5+6 = 3
permutations = [+, /, +, -, *]
1+2/3+4-5*6 = 0
permutations = [+, /, +, *, -]
1+2/3+4*5-6 = 19
permutations = [+, /, -, +, *]
1+2/3-4+5*6 = 12
permutations = [+, /, -, *, +]
1+2/3-4*5+6 = -9
permutations = [+, /, *, +, -]
1+2/3*4+5-6 = 3
permutations = [+, /, *, -, +]
1+2/3*4-5+6 = 5
permutations = [+, +, -, *, /]
1+2+3-4*5/6 = 1
permutations = [+, +, -, /, *]
1+2+3-4/5*6 = 0
permutations = [+, +, *, -, /]
1+2+3*4-5/6 = 3
permutations = [+, +, *, /, -]
1+2+3*4/5-6 = -2
permutations = [+, +, /, -, *]
1+2+3/4-5*6 = -24
permutations = [+, +, /, *, -]
1+2+3/4*5-6 = -1
permutations = [+, -, +, *, /]
1+2-3+4*5/6 = 3
permutations = [+, -, +, /, *]
1+2-3+4/5*6 = 0
permutations = [+, -, *, +, /]
1+2-3*4+5/6 = 0
permutations = [+, -, *, /, +]
1+2-3*4/5+6 = 6
permutations = [+, -, /, +, *]
1+2-3/4+5*6 = 30
permutations = [+, -, /, *, +]
1+2-3/4*5+6 = 6
permutations = [+, *, +, -, /]
1+2*3+4-5/6 = 1
permutations = [+, *, +, /, -]
1+2*3+4/5-6 = -4
permutations = [+, *, -, +, /]
1+2*3-4+5/6 = 1
permutations = [+, *, -, /, +]
1+2*3-4/5+6 = 7
permutations = [+, *, /, +, -]
1+2*3/4+5-6 = 1
permutations = [+, *, /, -, +]
1+2*3/4-5+6 = 3
permutations = [+, /, +, -, *]
1+2/3+4-5*6 = 0
permutations = [+, /, +, *, -]
1+2/3+4*5-6 = 19
permutations = [+, /, -, +, *]
1+2/3-4+5*6 = 12
permutations = [+, /, -, *, +]
1+2/3-4*5+6 = -9
permutations = [+, /, *, +, -]
1+2/3*4+5-6 = 3
permutations = [+, /, *, -, +]
1+2/3*4-5+6 = 5
permutations = [-, +, +, *, /]
1-2+3+4*5/6 = 5
permutations = [-, +, +, /, *]
1-2+3+4/5*6 = 6
permutations = [-, +, *, +, /]
1-2+3*4+5/6 = 2
permutations = [-, +, *, /, +]
1-2+3*4/5+6 = 7
permutations = [-, +, /, +, *]
1-2+3/4+5*6 = 30
permutations = [-, +, /, *, +]
1-2+3/4*5+6 = 6
permutations = [-, +, +, *, /]
1-2+3+4*5/6 = 5
permutations = [-, +, +, /, *]
1-2+3+4/5*6 = 6
permutations = [-, +, *, +, /]
1-2+3*4+5/6 = 2
permutations = [-, +, *, /, +]
1-2+3*4/5+6 = 7
permutations = [-, +, /, +, *]
1-2+3/4+5*6 = 30
permutations = [-, +, /, *, +]
1-2+3/4*5+6 = 6
permutations = [-, *, +, +, /]
1-2*3+4+5/6 = 1
permutations = [-, *, +, /, +]
1-2*3+4/5+6 = 6
permutations = [-, *, +, +, /]
1-2*3+4+5/6 = 1
permutations = [-, *, +, /, +]
1-2*3+4/5+6 = 6
permutations = [-, *, /, +, +]
1-2*3/4+5+6 = 11
permutations = [-, *, /, +, +]
1-2*3/4+5+6 = 11
permutations = [-, /, +, +, *]
1-2/3+4+5*6 = 54
permutations = [-, /, +, *, +]
1-2/3+4*5+6 = 26
permutations = [-, /, +, +, *]
1-2/3+4+5*6 = 54
permutations = [-, /, +, *, +]
1-2/3+4*5+6 = 26
permutations = [-, /, *, +, +]
1-2/3*4+5+6 = 11
permutations = [-, /, *, +, +]
1-2/3*4+5+6 = 11
permutations = [*, +, +, -, /]
1*2+3+4-5/6 = 0
permutations = [*, +, +, /, -]
1*2+3+4/5-6 = -5
permutations = [*, +, -, +, /]
1*2+3-4+5/6 = 1
permutations = [*, +, -, /, +]
1*2+3-4/5+6 = 6
permutations = [*, +, /, +, -]
1*2+3/4+5-6 = 0
permutations = [*, +, /, -, +]
1*2+3/4-5+6 = 2
permutations = [*, +, +, -, /]
1*2+3+4-5/6 = 0
permutations = [*, +, +, /, -]
1*2+3+4/5-6 = -5
permutations = [*, +, -, +, /]
1*2+3-4+5/6 = 1
permutations = [*, +, -, /, +]
1*2+3-4/5+6 = 6
permutations = [*, +, /, +, -]
1*2+3/4+5-6 = 0
permutations = [*, +, /, -, +]
1*2+3/4-5+6 = 2
permutations = [*, -, +, +, /]
1*2-3+4+5/6 = 1
permutations = [*, -, +, /, +]
1*2-3+4/5+6 = 6
permutations = [*, -, +, +, /]
1*2-3+4+5/6 = 1
permutations = [*, -, +, /, +]
1*2-3+4/5+6 = 6
permutations = [*, -, /, +, +]
1*2-3/4+5+6 = 11
permutations = [*, -, /, +, +]
1*2-3/4+5+6 = 11
permutations = [*, /, +, +, -]
1*2/3+4+5-6 = 3
permutations = [*, /, +, -, +]
1*2/3+4-5+6 = 5
permutations = [*, /, +, +, -]
1*2/3+4+5-6 = 3
permutations = [*, /, +, -, +]
1*2/3+4-5+6 = 5
permutations = [*, /, -, +, +]
1*2/3-4+5+6 = 7
permutations = [*, /, -, +, +]
1*2/3-4+5+6 = 7
permutations = [/, +, +, -, *]
1/2+3+4-5*6 = 12
permutations = [/, +, +, *, -]
1/2+3+4*5-6 = 29
permutations = [/, +, -, +, *]
1/2+3-4+5*6 = 24
permutations = [/, +, -, *, +]
1/2+3-4*5+6 = 1
permutations = [/, +, *, +, -]
1/2+3*4+5-6 = 11
permutations = [/, +, *, -, +]
1/2+3*4-5+6 = 13
permutations = [/, +, +, -, *]
1/2+3+4-5*6 = 12
permutations = [/, +, +, *, -]
1/2+3+4*5-6 = 29
permutations = [/, +, -, +, *]
1/2+3-4+5*6 = 24
permutations = [/, +, -, *, +]
1/2+3-4*5+6 = 1
permutations = [/, +, *, +, -]
1/2+3*4+5-6 = 11
permutations = [/, +, *, -, +]
1/2+3*4-5+6 = 13
permutations = [/, -, +, +, *]
1/2-3+4+5*6 = 36
permutations = [/, -, +, *, +]
1/2-3+4*5+6 = 11
permutations = [/, -, +, +, *]
1/2-3+4+5*6 = 36
permutations = [/, -, +, *, +]
1/2-3+4*5+6 = 11
permutations = [/, -, *, +, +]
1/2-3*4+5+6 = -1
permutations = [/, -, *, +, +]
1/2-3*4+5+6 = -1
permutations = [/, *, +, +, -]
1/2*3+4+5-6 = 3
permutations = [/, *, +, -, +]
1/2*3+4-5+6 = 5
permutations = [/, *, +, +, -]
1/2*3+4+5-6 = 3
permutations = [/, *, +, -, +]
1/2*3+4-5+6 = 5
permutations = [/, *, -, +, +]
1/2*3-4+5+6 = 7
permutations = [/, *, -, +, +]
1/2*3-4+5+6 = 7

출력
54
-24
*/
