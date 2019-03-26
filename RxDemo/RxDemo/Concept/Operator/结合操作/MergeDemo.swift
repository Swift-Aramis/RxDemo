//
//  MergeDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - 将多个 Observables 合并成一个
/**
 通过使用 merge 操作符你可以将多个 Observables 合并成一个，
 当某一个 Observable 发出一个元素时，他就将这个元素发出。
 
 如果，某一个 Observable 发出一个 onError 事件，
 那么被合并的 Observable 也会将它发出，并且立即终止序列。
 */
class MergeDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("🅰️")
        
        subject1.onNext("🅱️")
        
        subject2.onNext("①")
        
        subject2.onNext("②")
        
        subject1.onNext("🆎")
        
        subject2.onNext("③")
        
        /**
         🅰️
         🅱️
         ①
         ②
         🆎
         ③
         */
    }
    

}
