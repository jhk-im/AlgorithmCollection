package hash.test1

class HashCodingTest1 {

    fun solution(participant : Array<String>, completion : Array<String>) : String {
        var answer = ""

        val map = HashMap<String, Int>()

        for (player : String in participant) {

            /*map[player]?.let {
                map[player] = it + 1
            }

            if (map[player] == null) {
                map[player] = 1
            }*/

            map[player] = map.getOrDefault(player, 0) + 1
        }
        println(map)

        for (player : String in completion) {
            map[player]?.apply {
                map[player] = this - 1
            }
        }
        println(map)

        for (key : String in map.keys) {
            if (map[key] != 0) {
                answer = key
            }
        }
        println(map)

        return answer
    }
}
