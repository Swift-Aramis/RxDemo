//
//  Combine.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

//MARK: - 等待多个并发任务完成后处理结果
class Combine: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 同时取得老师信息和老师评论
        Observable.zip(
            CombineApi.teacher(teacherID: 123),
            CombineApi.teacherComments(teacherID: 123)
            ).subscribe(onNext: { (teacher, comments) in
                print("获取老师信息成功: \(teacher)")
                print("获取老师评论成功: \(comments.count) 条")
            }, onError: { (error) in
                print("获取老师信息或评论失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    

}

struct Teacher {
}

struct Comment {
}

enum CombineApi {
    /// 取得老师的详细信息
    static func teacher(teacherID: Int) -> Observable<Teacher> {
        //...
        return Observable<Teacher>.empty()
    }
    
    /// 取得老师的评论
    static func teacherComments(teacherID: Int) -> Observable<[Comment]> {
        //...
        return Observable<[Comment]>.empty()
    }
}
