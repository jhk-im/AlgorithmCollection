void main(List<String> arguments) {
  // 선택 정렬
  selectionSort();

  // 삽입 정렬
  insertSort();

  // 퀵 정렬
  quickSortStart();

  // 계수 정렬
  countSort();
}

void selectionSort() {
  print("선택 정렬");
  var array = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8];
  var minIndex = 0;

  for (int i = 0; i < array.length; i++) {
    minIndex = i; // 가장 작은 원소의 인덱스
    for (int j = i + 1; j < array.length; j++) {
      if (array[minIndex] > array[j]) {
        minIndex = j;
      }
    }

    // 스와프
    int swap = array[i];
    array[i] = array[minIndex];
    array[minIndex] = swap;

    print(array);
  }
}

void insertSort() {
  print("삽입 정렬");
  var array = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8];

  for (int i = 0; i < array.length; i++) {
    for (int j = i; j >= 1; j--) {
      // 인덱스 i부터 1까지 감소 반복문
      if (array[j] < array[j - 1]) {
        // 스와프
        int swap = array[j];
        array[j] = array[j - 1];
        array[j - 1] = swap;
      } else {
        break;
      }
    }
    print(array);
  }
}

void quickSortStart() {
  print("퀵 정렬");
  var array = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8];
  quickSort(array, 0, array.length - 1);
}

void quickSort(List<int> array, int pivot, int end) {
  // 원소가 1개인 경우 종료
  if (pivot >= end) {
    return;
  }

  var left = pivot + 1;
  var right = end;

  while (left <= right) {
    // 피벗보다 큰 데이터를 찾을 때 까지 반복
    while (left <= end && array[left] <= array[pivot]) {
      left += 1;
    }

    // 피벗보다 작은 데이터를 찾을 때까지 반복
    while (right > pivot && array[right] >= array[pivot]) {
      right -= 1;
    }

    if (left > right) {
      // 엇갈린 경우 작은 데이터와 피벗 교체
      int swap = array[right];
      array[right] = array[pivot];
      array[pivot] = swap;
    } else {
      // 엇갈리지 않은 경우 작은 데이터와 큰 데이터 교체
      int swap = array[left];
      array[left] = array[right];
      array[right] = swap;
    }

    print(array);
  }

  // 분할 이후 왼쪽, 오른쪽 각각 정렬 수행
  quickSort(array, pivot, right - 1);
  quickSort(array, right + 1, end);
}

void countSort() {
  print("계수 정렬");
  // 모든 원소의 값이 0보다 크거나 같다고 가정
  var array = [7, 5, 9, 0, 3, 1, 6, 2, 9, 1, 4, 8, 0, 5, 2];
  var max = array.reduce((curr, next) => curr > next ? curr : next) + 1;
  var count = List.filled(max, 0);

  print(array);

  for (int i in array) {
    count[i] += 1;
  }

  print(count);

  for (int i = 0; i < count.length; i++) {
    for (int j = 0; j < count[i]; j++) {
      print('$i ');
    }
  }
}
/*
선택 정렬
[0, 5, 9, 7, 3, 1, 6, 2, 4, 8]
[0, 1, 9, 7, 3, 5, 6, 2, 4, 8]
[0, 1, 2, 7, 3, 5, 6, 9, 4, 8]
[0, 1, 2, 3, 7, 5, 6, 9, 4, 8]
[0, 1, 2, 3, 4, 5, 6, 9, 7, 8]
[0, 1, 2, 3, 4, 5, 6, 9, 7, 8]
[0, 1, 2, 3, 4, 5, 6, 9, 7, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 9, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
삽입 정렬
[7, 5, 9, 0, 3, 1, 6, 2, 4, 8]
[5, 7, 9, 0, 3, 1, 6, 2, 4, 8]
[5, 7, 9, 0, 3, 1, 6, 2, 4, 8]
[0, 5, 7, 9, 3, 1, 6, 2, 4, 8]
[0, 3, 5, 7, 9, 1, 6, 2, 4, 8]
[0, 1, 3, 5, 7, 9, 6, 2, 4, 8]
[0, 1, 3, 5, 6, 7, 9, 2, 4, 8]
[0, 1, 2, 3, 5, 6, 7, 9, 4, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 9, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
퀵 정렬
[7, 5, 4, 0, 3, 1, 6, 2, 9, 8]
[2, 5, 4, 0, 3, 1, 6, 7, 9, 8]
[2, 1, 4, 0, 3, 5, 6, 7, 9, 8]
[2, 1, 0, 4, 3, 5, 6, 7, 9, 8]
[0, 1, 2, 4, 3, 5, 6, 7, 9, 8]
[0, 1, 2, 4, 3, 5, 6, 7, 9, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 9, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 9, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
계수 정렬
[7, 5, 9, 0, 3, 1, 6, 2, 9, 1, 4, 8, 0, 5, 2]
[2, 2, 2, 1, 1, 2, 1, 1, 1, 2]
0 
0 
1 
1 
2 
2 
3 
4 
5 
5 
6 
7 
8 
9 
9
*/