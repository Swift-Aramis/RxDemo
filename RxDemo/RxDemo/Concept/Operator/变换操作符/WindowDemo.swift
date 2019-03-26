//
//  WindowDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//MARK: - window
/**
 window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
 同时 buffer 要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
 */
class WindowDemo: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         public func window(timeSpan: RxTimeInterval, count: Int, scheduler: SchedulerType) -> RxSwift.Observable<RxSwift.Observable<Self.E>>
         */
        
        let subject = PublishSubject<String>()
        //每3个元素作为一个子Observable发出。
        subject.window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                print("subscribe: \($0)")
                $0.asObservable()
                    .subscribe(onNext: { print($0) })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        /**
         subscribe: ===
         a
         b
         c
         subscribe: ===
         1
         2
         3
         subscribe: ===
         subscribe: ===
         subscribe: ===
         */
    }

}
