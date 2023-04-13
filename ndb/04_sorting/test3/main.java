import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static class Student {
        String name;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        int count;

        public int getCount() {
            return count;
        }

        public void setCount(int count) {
            this.count = count;
        }


        public Student(String name, int count) {
            this.name = name;
            this.count = count;
        }
    }
    public static void main(String[] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        try {
            // n 입력 받기
            String input = br.readLine();
            int n = Integer.parseInt(input);

            List<Student> list = new ArrayList<>();

            // n 명의 학생 정보 입력받아 리스트에 저장
            for (int i = 0; i < n; i++) {
                BufferedReader br2 = new BufferedReader(new InputStreamReader(System.in));
                String[] input2 = br2.readLine().split(" ");
                Student student = new Student(input2[0], Integer.parseInt(input2[1]));
                list.add(student);
            }

            // 점수 기준으로 내림차순 정렬
            list.sort(Comparator.comparing(Student::getCount).thenComparing(Student::getName));

            for (Student student : list) {
                System.out.print(student.name + " "); // 정답 출력
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
