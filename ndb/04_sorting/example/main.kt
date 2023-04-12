import java.util.*

fun main(args: Array<String>) {
    // 선택 정렬
    selectionSort()

    // 삽입 정렬
    insertSort()

    // 퀵 정렬
    quickSort()

    // 계수 정렬
    countSort()
}

fun selectionSort() {
    println("선택 정렬")
    val array = intArrayOf(7, 5, 9, 0, 3, 1, 6, 2, 4, 8)
    var minIndex: Int
    for (i in array.indices) {
        minIndex = i // 가장 작은 원소의 인덱스
        for (j in i + 1 until array.size) {
            if (array[minIndex] > array[j]) {
                minIndex = j
            }
        }

        // 스와프
        array[i] = array[minIndex].also { array[minIndex] = array[i] }
        println(array.contentToString())
    }
}

fun insertSort() {
    println("삽입 정렬")

    val array = intArrayOf(7, 5, 9, 0, 3, 1, 6, 2, 4, 8)
    for (i in array.indices) {
        for (j in i downTo 1) { // 인덱스 i부터 1까지 감소 반복문
            if (array[j] < array[j - 1]) {
                // 스와프
                array[j] = array[j - 1].also { array[j - 1] = array[j] }
            } else {
                break
            }
        }
        println(array.contentToString())
    }
}

fun quickSort() {
    println("퀵 정렬")
    val array = intArrayOf(7, 5, 9, 0, 3, 1, 6, 2, 4, 8)
    quickSort(array, 0, array.size - 1)
}

fun quickSort(array: IntArray, pivot: Int, end: Int) {
    // 원소가 1개인 경우 종료
    if (pivot >= end) {
        return
    }

    var left = pivot + 1
    var right = end

    while (left <= right) {
        // 피벗보다 큰 데이터를 찾을 때 까지 반복
        while (left <= end && array[left] <= array[pivot]) {
            left += 1
        }

        // 피벗보다 작은 데이터를 찾을 때까지 반복
        while (right > pivot && array[right] >= array[pivot]) {
            right -= 1
        }

        if (left > right) { // 엇갈린 경우 작은 데이터와 피벗 교체
            array[right] = array[pivot].also { array[pivot] = array[right] }
        } else { // 엇갈리지 않은 경우 작은 데이터와 큰 데이터 교체
            array[left] = array[right].also { array[right] = array[left] }
        }

        println(array.contentToString())
    }

    // 분할 이후 왼쪽, 오른쪽 각각 정렬 수행
    quickSort(array, pivot, right - 1)
    quickSort(array, right + 1, end)
}

fun countSort() {
    println("계수 정렬")
    // 모든 원소의 값이 0보다 크거나 같다고 가정
    val array = intArrayOf(7, 5, 9, 0, 3, 1, 6, 2, 9, 1, 4, 8, 0, 5, 2)
    val count = IntArray(Arrays.stream(array).max().asInt + 1)
    println(array.contentToString())
    for (i in array) {
        count[i] += 1
    }
    println(count.contentToString())
    for (i in count.indices) {
        for (j in 0 until count[i]) {
            print("$i ")
        }
    }
}
