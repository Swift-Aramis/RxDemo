//
//  CatchErrorJustReturnDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/9.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 错误处理操作（Error Handling Operators）
 错误处理操作符可以用来帮助我们对 Observable 发出的 error 事件做出响应，或者从错误中恢复
 */
enum MyError: Error {
    case A
    case B
}

//MARK: - catchErrorJustReturn
/**
 当遇到 error 事件的时候，就返回指定的值，然后结束。
 */
class CatchErrorJustReturnDemo: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
        
        /**
         a
         b
         c
         错误
         */
    }

}
