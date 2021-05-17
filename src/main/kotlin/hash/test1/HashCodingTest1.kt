package hash.test1

class HashCodingTest1 {

    fun solution(participant : Array<String>, completion : Array<String>) : String {
        var answer = ""

        val map = HashMap<String, Int>()

        for (player : String in participant) {
            map[player] = map.getOrDefault(player, 0) + 1
        }

        for (player : String in completion) {
            map[player]?.apply {
                map[player] = this - 1
            }
        }

        for (key : String in map.keys) {
            if (map[key] != 0) {
                answer = key;
            }
        }

        return answer
    }
}