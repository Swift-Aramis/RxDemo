//
//  AsyncSubjectDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 AsyncSubject 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），
 如果源 Observable 没有发出任何元素，只有一个完成事件。
 那 AsyncSubject 也只有一个完成事件。
 
 它会对随后的观察者发出最终元素。
 如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
 */
class AsyncSubjectDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let disposeBag = DisposeBag()
        let subject = AsyncSubject<String>()
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        subject.onNext("🐹")
        subject.onCompleted()
        
        /**
         Subscription: 1 Event: next(🐹)
         Subscription: 1 Event: completed
         */
    }

}
