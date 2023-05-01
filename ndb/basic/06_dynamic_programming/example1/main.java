public class Main {
    public static void main(String[] args) {
        // 탑다운 방식 재귀함수
        System.out.println("탑다운");
        fibo(29);

        // 바텀업 방식 반복문
        System.out.println("바텀업");
        int[] dx = new int[30];
        dx[1] = 1;
        dx[2] = 1;
        int n = 29;
        for (int i = 3; i < n + 1; i++) {
            dx[i] = dx[i - 1] + dx[i - 2];
            System.out.println(dx[i]);
        }
    }
    // 계산된 결과를 메모이제이션(Memoization)하기 위한 리스트
    private static final int[] d = new int[30];

    public static int fibo(int x) {
        if (d[x] != 0) return d[x]; // 이미 계산한 적 있는 문제는 그대로 반환
        if (x == 0) return 0;
        else if (x == 1 || x == 2) return 1; // 종료 조건(1 혹은 2일때 1 반환)

        //아직 계산하지 않은 문제는 점화식에 따라 비보나치 결과 반환
        d[x] = fibo(x - 1) + fibo(x - 2);
        System.out.println(d[x]);
        return d[x];
    }
}
/*
탑다운
2
3
5
8
13
21
34
55
89
144
233
377
610
987
1597
2584
4181
6765
10946
17711
28657
46368
75025
121393
196418
317811
514229
바텀업
2
3
5
8
13
21
34
55
89
144
233
377
610
987
1597
2584
4181
6765
10946
17711
28657
46368
75025
121393
196418
317811
514229
*/