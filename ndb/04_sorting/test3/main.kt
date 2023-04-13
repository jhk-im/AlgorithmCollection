internal class Student(var name: String, var count: Int)

fun main(args: Array<String>) {
    readlnOrNull()?.let { rn ->
        // n 입력 받기
        val n = rn.toInt()

        val list = ArrayList<Student>()

        // 2차원 리스트 맵 정보 입력 받기
        for (i in 0 until n) {
            readlnOrNull()?.let { rn2 ->
                val input = rn2.split(' ')
                val student = Student(input[0], input[1].toInt())
                list.add(student)
            }
        }

        // 점수 기준으로 내림차순 정렬
        list.sortWith(
            Comparator.comparing { obj: Student -> obj.count }.thenComparing { obj: Student -> obj.name }
        )
        
        for (student in list) {
            print("${student.name} ")
        }
    }
}
