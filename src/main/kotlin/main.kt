import hash.test2.HashCodingTest2

val hash2 by lazy { HashCodingTest2() }

val phoneBook1 = arrayOf("119", "97674223", "1195524421")
val phoneBook2 = arrayOf("123", "456", "789")
val phoneBook3 = arrayOf("12","123","1235","567","88")

fun main(args: Array<String>) {
    println(hash2.solution(phoneBook1))
    println(hash2.solution(phoneBook2))
    println(hash2.solution(phoneBook3))
}