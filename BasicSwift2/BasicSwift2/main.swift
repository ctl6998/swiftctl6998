//
//  main.swift
//  BasicSwift2
//
//  Created by Chí Thành on 2/8/24.
//

import Foundation

// Class: tham chieu
//class Retangle1 {
//    var width: Int = 2
//    var height: Int = 3
//    init (width: Int, height: Int) {
//        self.width = width
//        self.height = height
//    }
//    func area() -> Int {
//        return width * height
//    }
//}
//func main() {
//    let rec1 = Retangle1(width: 4, height: 5)
//    print("rec1.width = \(rec1.width)")
//    print("rec1.height = \(rec1.height)")
//    print("area = \(rec1.area())")
//}
//
//main()

// Struct: tham tri
//struct Employee {
//    var empNumber: String
//    var empName: String
//    var position: String
//    init(empNumber: String, empName: String, position: String) {
//        self.empNumber = empNumber
//        self.empName = empName
//        self.position = position
//    }
//}
//
//func test_EmployeeStruct() {
//    let john = Employee(empNumber:"E01",empName: "John",position: "CLERK")
//    print("Emp Number: " + john.empNumber)
//    print("Emp Name: " + john.empName)
//    print("Emp Position: " + john.position)
//}

// Map: thay doi array

// Filter: tra ve array moi

// Reduce: Ket hop tat ca item thanh 1 gia tri moi

// Flatmap:
// Compactmap:
// Chaning:

/**
 Viết chương trình quản lý lớp học, quản lý sinh viên.
  Mỗi lớp học có các thuộc tính: id, tên lớp, tên GVCN, danh sách sinh viên (mảng sinh viên)
  Mỗi đối tượng sinh viên có các thuộc tính: id, tên, giới tính, tuổi, điểm toán, điểm văn, điểm anh, điểm trung bình và học lực.
  
  Các chức năng::
  - Thêm sinh viên x
  - Cập nhật thông tin sinh viên theo ID
  - Xoá sinh viên theo ID x
  - Tìm kiếm sinh viên theo tên x
  - Sắp xếp sinh viên theo điểm trung bình
  - Hiển thị danh sách sinh viên x
 */


struct Student {
    let id: String
    var name: String
    var gender: String
    var age: Int
    var mathScore: Double
    var englishScore: Double
    var averageScore: Double
    var status: String
    
    init(id: String, name: String, gender: String, age: Int, mathScore: Double, englishScore: Double, status: String) {
        self.id = UUID().uuidString
        self.name = name
        self.gender = gender
        self.age = age
        self.mathScore = mathScore
        self.englishScore = englishScore
        self.averageScore = Student.calculateAverage(mathScore: mathScore, englishScore: englishScore)
        self.status = status
    }
    
    static func calculateAverage(mathScore: Double, englishScore: Double) -> Double {
        return (mathScore + englishScore) / 2
    }
}

struct Teacher {
    let id: String
    let name: String
    let gender: String
    let age: Int
    
    init(id: String, name: String, gender: String, age: Int, classId: Int) {
        self.id = UUID().uuidString
        self.name = name
        self.gender = gender
        self.age = age
    }
}


class Class {
    let id: String
    let name: String
    let teacherId: String
    var students: [Student]
    
    init(name: String, teacherId: String) {
        self.id = UUID().uuidString
        self.name = name
        self.teacherId = teacherId
        self.students = []
    }
    
    func addStudent(_ student: Student) {
        students.append(student)
    }
    
    func deleteStudent(byID studentID: String) -> Bool {
        if let index = students.firstIndex(where: { $0.id == studentID }) {
            students.remove(at: index)
            return true
        }
        return false
    }
    
    func searchStudent(byName name: String) -> [Student] {
        return students.filter { $0.name.lowercased().contains(name.lowercased()) }
    }
    
    func showStudents() {
        for student in students {
            print("ID: \(student.id), Name: \(student.name), Gender: \(student.gender), Age: \(student.age), Average Score: \(student.averageScore), Status: \(student.status)")
        }
    }
    
    func updateStudent(byID studentID: String, name: String? = nil, gender: String? = nil, age: Int? = nil, mathScore: Double? = nil, englishScore: Double? = nil, status: String? = nil) -> Bool {
        if let index = students.firstIndex(where: { $0.id == studentID }) {
            var student = students[index]
            
            student.name = name ?? student.name
            student.gender = gender ?? student.gender
            student.age = age ?? student.age
            student.mathScore = mathScore ?? student.mathScore
            student.englishScore = englishScore ?? student.englishScore
            student.status = status ?? student.status
            
            if mathScore != nil || englishScore != nil {
                student.averageScore = Student.calculateAverage(mathScore: student.mathScore, englishScore: student.englishScore)
            }
            
            students[index] = student
            return true
        }
        return false
    }
    
    func orderStudentsByAverageScore() {
        students.sort { $0.averageScore > $1.averageScore }
    }
}

// Demo
// Create some students
let student1 = Student(id: UUID().uuidString, name: "Alice", gender: "Female", age: 20, mathScore: 85.0, englishScore: 90.0, status: "Active")
let student2 = Student(id: UUID().uuidString, name: "Bob", gender: "Male", age: 22, mathScore: 78.0, englishScore: 88.0, status: "Active")
let student3 = Student(id: UUID().uuidString, name: "Charlie", gender: "Male", age: 21, mathScore: 92.0, englishScore: 85.0, status: "Active")

// Create a teacher
let teacher1 = Teacher(id: UUID().uuidString, name: "Mr. Smith", gender: "Male", age: 45, classId: 1)

// Create a class and assign the teacher to it
let mathClass = Class(name: "Math 101", teacherId: teacher1.id)

// Add students to the class
mathClass.addStudent(student1)
mathClass.addStudent(student2)
mathClass.addStudent(student3)

// Show the list of students in the class
print("============================================================")
print("Students in the class:")
mathClass.showStudents()

// Order students by average score
mathClass.orderStudentsByAverageScore()

// Show the list of students ordered by average score
print("============================================================")
print("\nStudents ordered by average score:")
mathClass.showStudents()

// Search for a student by name
print("============================================================")
print("\nSearch results for 'Alice':")
let searchResults = mathClass.searchStudent(byName: "Alice")
for student in searchResults {
    print("Student: \(student.name), ID: \(student.id)")
}

// Delete a student by ID
print("============================================================")
let studentIDToDelete = student1.id
let success = mathClass.deleteStudent(byID: studentIDToDelete)
if success {
    print("\nStudent \(student1.name) deleted successfully.")
} else {
    print("\nFailed to delete student.")
}

// Update student
print("============================================================")
let studentIDToUpdate = student2.id
let updateSuccessful = mathClass.updateStudent(byID: studentIDToUpdate, name: "Bob Johnson", gender: "Female", age: 21, mathScore: 88.0, englishScore: 92.0, status: "Active")
if updateSuccessful {
    print("Student updated successfully.")
} else {
    print("Failed to update student.")
}
print("Students after update:")
mathClass.showStudents()

