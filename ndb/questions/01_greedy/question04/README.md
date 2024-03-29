# 만들 수 없는 금액

## 문제 설명

* N개의 동전이 주어짐

`동전을 이용하여 만들 수 없는 양의 정수의 최솟값을 출력하시오`

입력 조건

* 첫째 줄에 동전의 갯수 S이 주어짐(1 <= N <= 1,000)
* 둘째 줄에 각 동전의 화폐 단위가 공백을 포함한 자연수로 주어짐 (1 <= 화폐 <= 1,000,000)

```txt
5
3 2 1 1 9
```

출력 조건

* 동전을 이용하여 만들 수 없는 양의 정수의 최솟값을 출력

```txt
8
```

### 해결 과정

* 정렬을 이용한 그리디 알고리즘
* 화폐 단위 기준으로 오름차순 정렬
* 1부터 순차적으로 특정한 금액을 만들 수 있는지 확인

```txt
0.
* [3, 2, 1, 1, 9] 오름차순 정렬
  * [1, 1, 2, 3, 9]
* target = 1
```

```txt
1. 
* [v1, 1, 2, 3, 9]
  * index[0] = 1 / target(1)
  * 배열에 target이 존재함
  * target = 1 + 1 = 2
  * 1까지 모든 금액을 만들 수 있다는 의미
```

```txt
2.
* [v1, v1, 2, 3, 9]
  * index[1] = 1 / target(2)
  * 배열에 target이 존재함
  * target = 2 + 1 = 3
  * 2까지의 모든 금액을 만들 수 있다는 의미
```

```txt
3.
* [v1, v1, v2, 3, 9]
  * index[2] = 2 / target(3)
  * 배열에 target이 존재함
  * target = 3 + 2 = 5
  * 4까지의 모든 금액을 만들 수 있다는 의미
```

```txt
4.
* [v1, v1, v2, v3, 9]
  * index[3] = 3 / target(5)
  * 배열에 target이 존재하지 않음
  * index[3] < target(5)
  * target = 5 + 3 = 8
  * 7까지의 모든 금액을 만들 수 있다는 의미
```

```txt
5.
* [v1, v1, v2, v3, v9]
  * index[4] = 9 / target(8)
  * 배열에 target이 존재하지 않음
  * index[4] > target(8)
```

`정답 = 8`
