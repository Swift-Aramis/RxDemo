//
//  FlatMapFirstDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/3.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
/**
 flatMapFirst 与 flatMapLatest 正好相反：flatMapFirst 只会接收最初的 value 事件。
 */
/**
 该操作符可以防止重复请求：
 比如点击一个按钮发送一个请求，当该请求完成前，该按钮点击都不应该继续发送请求。便可该使用 flatMapFirst 操作符。
 */
class FlatMapFirstDemo: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")

        let variable = Variable(subject1)
        
        variable.asObservable().flatMapFirst { $0 }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
        
        /**
         只会执行subject1
         A
         B
         C
         */
        
    }

}
