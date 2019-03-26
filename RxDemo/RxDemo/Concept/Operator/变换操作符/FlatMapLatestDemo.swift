//
//  FlatMapLatestDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - flatMapLatest
/**
 将 Observable 的元素转换成其他的 Observable，然后取这些 Observables 中最新的一个
 
 flatMapLatest 操作符将源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。
 一旦转换出一个新的 Observable，就只发出它的元素，旧的 Observables 的元素将被忽略掉。
 */

/**
 flatMapLatest 与 flatMap 的唯一区别是：flatMapLatest 只会接收最新的 value 事件。
 */
class FlatMapLatestDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        let first = BehaviorSubject(value: "👦🏻")
        let second = BehaviorSubject(value: "🅰️")
        let variable = Variable(first)
        
        variable.asObservable()
            .flatMapLatest { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        first.onNext("🐱")
        variable.value = second
        second.onNext("🅱️")
        first.onNext("🐶")

        /**
         👦🏻
         🐱
         🅰️
         🅱️
         */
    }

}
