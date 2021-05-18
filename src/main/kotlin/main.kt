import hash.test1.HashCodingTest1

val hash1 by lazy { HashCodingTest1() }
val participant = arrayOf("kjh", "yhh", "lmj", "kkh", "pcs", "hsd", "yhh")
val completion = arrayOf("kjh", "lmj", "kkh", "pcs", "hsd","yhh")

fun main(args: Array<String>) {
    println(hash1.solution(participant, completion))

    val s1 = "string"
    val s2 = "string"
    println(s1.hashCode()) // -891985903
    println(s2.hashCode()) // -891985903
    println(s1==s2) // true

    val hashMap = HashMap<String, Int>()
    hashMap["s1"] = 1
    hashMap["s2"] = 3
    hashMap["s2"] = 2
    println(hashMap)
}