# 문자열 압축

## 문제 설명

* 문자열 S가 주어짐
* 문자열에 같은 값이 연속해서 나타나는 것을 문자의 개수와 반복되는 값으로 표현하고자 함
  * aabbaccc -> 2a2ba3c
  * ababcdcdababcdcd -> 압축되지 않음
    * 2ab2cd2ab2cd or 2ababcdcd
    * 후자가 가장 짧게 압축하여 표현한 것
* 문자열은 맨 앞부터 정해진 길이만큼 잘라야 함
  * a/abba/ccc -> x

`문자열 S가 주어질 때 1개 이상 단위로 문자열로 잘라 압축하는 표현중 가장 짧은 것의 길이를 return하도록 solution함수를 작성하시오`

제한 사항

* 1 <= S <= 1000
* S는 알파벳 소문자로 이루어져 있음

입출력 예시

|S|Result||
|-|-|-|
|"aabbaccc"|7|"2a2ba3c"|
|"ababcdcdababcdcd"|9|"2ababcdcd"|
|"abcabcdede"|8|"2abcdede"|
|"abcabcabcabcdededededede"|14|"2abcabc2dedede"|
|"xababcdcdababcdcd"|17|"xababcdcdababcdcd"|

### 해결 과정

* 문자열 길이가 1000 이하
* 문자열 길이 / 2 까지만 확인
  * abcde
  * abc/de -> 반복되지 않으므로 의미가 없음
* 요구사항에 맞추어 충실히 구현하면 됨

```txt
1.
* 입력 = aabbaccc
* step = 1 (한글자씩 확인)
* prev = 문자열(0,1) = a
* count = 1
* 문자열 길이(8) / 2 + 1 = 5
  * step이 1부터 시작
```

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev|*|||||||||
|count|1||||||||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev|*||||||||
|count|1|2|||||||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev||*|||||||
|count|1|2|1||||||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev|||*||||||
|count|1|2|1|2|||||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev||||*|||||
|count|1|2|1|2|1||||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev|||||*||||
|count|1|2|1|2|1|1|||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev||||||*|||
|count|1|2|1|2|1|1|2||

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev|||||||*||
|count|1|2|1|2|1|1|2|3|

|-|a|a|b|b|a|c|c|c|
|-|-|-|-|-|-|-|-|-|
|prev||||||||*|
|count|1|2|1|2|1|1|2|3|

2a2bac3 = 7

```txt
2.
* 입력 = aabbaccc
* step = 2 (두글자씩 확인)
* prev = 문자열(0,2) = aa
* count = 1
* 문자열 길이(8) / 2 + 1 = 5
  * step이 1부터 시작
```

|-|aa|bb|ac|cc|
|-|-|-|-|-|
|prev|*||||
|count|1||||

|-|aa|bb|ac|cc|
|-|-|-|-|-|
|prev|*||||
|count|1|1|||

|-|aa|bb|ac|cc|
|-|-|-|-|-|
|prev||*|||
|count|1|1|1||

|-|aa|bb|ac|cc|
|-|-|-|-|-|
|prev|||*||
|count|1|1|1|1|

|-|aa|bb|ac|cc|
|-|-|-|-|-|
|prev||||*|
|count|1|1|1|1|

aabbaccc = 8

...

* 같은 방식으로 문자열 길이의 절반인 step4까지 확인
* 결과
  * 2a2bac3 = 7 출력
