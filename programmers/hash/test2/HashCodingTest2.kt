package hash.test2


class HashCodingTest2 {

    fun solution(phoneBook: Array<String>): Boolean {
        val hashMap = HashMap<String, String?>()
        for (phone in phoneBook) {
            hashMap[phone] = phone
        }
        for (key in hashMap.keys) {
            for (i in key.indices) {
                println(key.substring(0, i))
                if (hashMap.containsKey(key.substring(0, i))) return false
            }
        }
        return true
    }
}
