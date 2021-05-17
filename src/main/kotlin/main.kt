import hash.test1.HashCodingTest1

val hash1 by lazy { HashCodingTest1() }
val participant = arrayOf("kjh", "lmj", "kkh", "pcs", "hsd", "yhh")
val completion = arrayOf("kjh", "lmj", "kkh", "pcs", "hsd")

fun main(args: Array<String>) {
    print(hash1.solution(participant, completion))
}