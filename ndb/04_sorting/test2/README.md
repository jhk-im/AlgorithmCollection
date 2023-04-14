# 성적이 낮은 순서로 출력하기

## 문제 설명

* N명의 학생 정보가 있음
* 학생 정보는 학생의 이름과 성적이 공백으로 구분됨

`성적이 낮은 순서대로 학생의 이름을 출력하시오.`

입력조건

* 첫째 줄에 학생의 수 N이 주어짐(1 <= N <= 100,000)
* 두 번째 줄부터 N + 1 줄부터 이름과 성적이 공백으로 주어짐
* 성적은 100 이하의 자연수

```txt
2
김코딩 49
이자바 92
```

출력조건

* 모든 학생의 이름을 성적이 낮은 순으로 출력
* 성적이 중복되는 경우 순서는 상관없음

```txt
김코딩 이자바
```

### `해결 과정`

* 최대 100,000까지 입력될 수 있으므로 최악의 경우 O(NlogN)을 보장하는 알고리즘을 이용하거나 계수 정렬을 이용하면 됨
* 내가 사용하는 언어의 기본 정렬 라이브러리 사용