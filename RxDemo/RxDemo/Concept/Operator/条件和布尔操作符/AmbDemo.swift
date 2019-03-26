//
//  AmbDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
/**
 条件和布尔操作符（Conditional and Boolean Operators）
 条件和布尔操作会根据条件发射或变换 Observables，或者对他们做布尔运算。
 */

//MARK: - amb
/**
 当传入多个 Observables 到 amb 操作符时，它将取第一个发出元素或产生事件的 Observable，然后只发出它的元素。并忽略掉其他的 Observables。
 */
class AmbDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        let subject3 = PublishSubject<Int>()
        
        subject1
            .amb(subject2)
            .amb(subject3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(1)
        subject1.onNext(20)
        subject2.onNext(2)
        subject1.onNext(40)
        subject3.onNext(0)
        subject2.onNext(3)
        subject1.onNext(60)
        subject3.onNext(0)
        subject3.onNext(0)
        
        /**
         1
         2
         3
         */
    }

}
