# TEST3 : 1이 될 때까지

## 문제 설명

어떠한 수 N이 1이 될 때까지 다음의 두 과정 중 하나를 반복적으로 선택하여 수행하려고 한다. 단, 두 번째 연산은 N이 K로 나누어떨어질 때만 선택할 수 있다.

1. N에서 1을 뺀다.
2. N을 K로 나눈다.

입력 조건

* (2 <= N <= 100,000)
* (2 <= K <= 100,000)
* N과 K가 공백으로 구분되며 각각 자연수로 주어진다.
* N은 항상 K보다 크거나 같다.

출력조건

* 첫째 줄에 N이 1일 될 때까지 1번 혹은 2번의 과정을 수행해야 하는 횟수의 최솟값을 출력한다.

### 해결 과정

* 주어진 N에 대하여 최대한 많이 나누기를 수행
* 2이상의 수로 나누는 것이 1을 빼는 것 보다 숫자를 훨씬 많이 줄일 수 있기 때문
