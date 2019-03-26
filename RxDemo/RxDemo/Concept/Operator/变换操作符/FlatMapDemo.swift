//
//  FlatMapDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - flatMap
/**
 将 Observable 的元素转换成其他的 Observable，然后将这些 Observables 合并
 
 flatMap 操作符将源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。
 然后将这些 Observables 的元素合并之后再发送出来。
 
 这个操作符是非常有用的，例如，当 Observable 的元素本身拥有其他的 Observable 时，
 你可以将所有子 Observables 的元素发送出来。
 */

/**
 map 在做转换的时候容易出现“升维”的情况。即转变之后，从一个序列变成了一个序列的序列。
 而 flatMap 操作符会对源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。 然后将这些 Observables 的元素合并之后再发送出来。即又将其 "拍扁"（降维）成一个 Observable 序列。
 这个操作符是非常有用的。比如当 Observable 的元素本生拥有其他的 Observable 时，我们可以将所有子 Observables 的元素发送出来。
 */

class FlatMapDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        let first = BehaviorSubject(value: "👦🏻")
        let second = BehaviorSubject(value: "🅰️")
        let variable = Variable(first)
        
        variable.asObservable()
            .flatMap { $0 }
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
         🐶
         */
    }

}
