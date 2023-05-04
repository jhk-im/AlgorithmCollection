# 문자열 재정렬

## 문제 설명

* 알파벳 대문자, 숫자(0 ~ 9)로만 구성된 문자열이 입력으로 주어짐
* 알파벳을 오름차순으로 정렬
* 숫자를 모두 더함

`위 내용을 충족하여 알파벳(오름차순 정렬) + 숫자(모두 더한 값)을 출력하시오`

입력 조건

* 첫째 줄에 문자열 S가 주어짐(1 <= S <= 10,000)

```txt
K1KA5CB7
```

출력 조건

* 알파벳(오름차순 정렬) + 숫자(모두 더한 값)을 출력

```txt
ABCKK13
```

### 해결 과정

* 문자열을 배열에 추가하고 오름차순 정렬
* 배열을 모두 검색하면서 정규표현식을 사용하여 숫자 판별
* 숫자와 문자를 각각 요구사항에 맞게 각각의 변수에 추가
* 문자 + 숫자 출력