//
//  BehaviorSubjectDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。
 然后将随后产生的元素发送出来。
 
 如果源 Observable 因为产生了一个 error 事件而中止， BehaviorSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
 */
class BehaviorSubjectDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        let subject = BehaviorSubject(value: "🔴")
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
        
        subject
            .subscribe { print("Subscription: 3 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🍐")
        subject.onNext("🍊")

        /**
         Subscription: 1 Event: next(🔴) => 默认元素
         Subscription: 1 Event: next(🐶)
         Subscription: 1 Event: next(🐱)
         
         Subscription: 2 Event: next(🐱) => 最新的元素
         Subscription: 1 Event: next(🅰️)
         Subscription: 2 Event: next(🅰️)
         Subscription: 1 Event: next(🅱️)
         Subscription: 2 Event: next(🅱️)
         
         Subscription: 3 Event: next(🅱️) => 最新的元素
         Subscription: 1 Event: next(🍐)
         Subscription: 2 Event: next(🍐)
         Subscription: 3 Event: next(🍐)
         Subscription: 1 Event: next(🍊)
         Subscription: 2 Event: next(🍊)
         Subscription: 3 Event: next(🍊)
         */
    }

}
