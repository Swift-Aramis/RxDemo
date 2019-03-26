//
//  Functional.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

/**
 函数响应式编程是种编程范式。
 它是通过构建函数操作数据序列，然后对这些序列做出响应的编程方式。
 它结合了 函数式编程 以及 响应式编程
 */
class Functional: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - 函数式编程
    /**
     函数式编程是种编程范式，
     它需要我们将函数作为参数传递，或者作为返回值返还。
     我们可以通过组合不同的函数来得到想要的结果。
     */
    func functional() {
        
        // 全校学生
        let allStudents: [Student] = getSchoolStudents()
        
        // 三年二班的学生
        let gradeThreeClassTwoStudents: [Student] = allStudents.filter { student in
            student.gradeN == 3 && student.classN == 2
        }
        
        //>>>>>>>精简写法>>>>>>>
        _ = allStudents.filter { $0.gradeN == 3 && $0.classN == 2 }
        
        // 三年二班的每一个男同学唱一首《一剪梅》
        gradeThreeClassTwoStudents
            .filter({ student in student.sex == .boy })
            .forEach { (boy) in boy.singASong(name: "一剪梅")}
        
        //>>>>>>>精简写法>>>>>>>
        gradeThreeClassTwoStudents
            .filter { $0.sex == .boy }
            .forEach { $0.singASong(name: "一剪梅")}
        
        // 三年二班学生成绩高于90分的家长上台领奖
        gradeThreeClassTwoStudents
            .filter { student in student.score > 90 }
            .map { student in student.parent }
            .forEach { (parent) in parent.receiveAPrize() }
        
        //>>>>>>>精简写法>>>>>>>
        gradeThreeClassTwoStudents
            .filter({ $0.score > 90 })
            .map({ $0.parent })
            .forEach({ $0.receiveAPrize() })
        
        // 由高到低打印三年二班的学生成绩
        gradeThreeClassTwoStudents
            .sorted { st0, st1 in st0.score > st1.score }
            .forEach { student in print("score: \(student.score), name: \(student.name)") }
        
        //>>>>>>>精简写法>>>>>>>
        gradeThreeClassTwoStudents
            .sorted { $0.score > $1.score }
            .forEach { print("score: \($0.score), name: \($0.name)")}
        
        
        //二年一班分数不足60的学生唱一首《我有罪》。
        let gradeTwoClassOneStudents: [Student] = allStudents.filter { (student) in
            student.gradeN == 2 && student.classN == 1
        }
        gradeTwoClassOneStudents
            .filter { (student) -> Bool in student.score < 60 }
            .forEach { (student) in student.singASong(name: "《我有罪》") }
        
        //>>>>>>>精简写法>>>>>>>
        allStudents
            .filter({ $0.gradeN == 2 && $0.classN == 1 && $0.score < 60})
            .forEach({ $0.singASong(name: "《我有罪》")})
    }
    
    func getSchoolStudents() -> [Student] {
        return [Student]()
    }

}

enum Gender {
    case boy
    case girl
}

struct Parent {
    
    func receiveAPrize() {
        print("receiveAPrize")
    }
}

struct Student {
    
    let gradeN = 0
    let classN = 0
    let name = ""
    let sex: Gender = .boy
    let score = 0
    let parent: Parent = Parent()
    
    
    func singASong(name: String) {
        print("singASong \(name)")
    }
}
