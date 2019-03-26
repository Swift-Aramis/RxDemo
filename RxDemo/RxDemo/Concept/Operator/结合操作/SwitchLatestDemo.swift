//
//  SwitchLatestDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/3.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - switchLatest
/**
 switchLatest 有点像其他语言的 switch 方法，可以对事件流进行转换。
 比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2。
 */
class SwitchLatestDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject1.onNext("C")
        
        //改变事件源
        variable.value = subject2
        subject1.onNext("D")
        subject2.onNext("2")
        
        //改变事件源
        variable.value = subject1
        subject2.onNext("3")
        subject1.onNext("E")
        
        /**
         A
         B
         C
         1
         2
         D
         E
         */
    }

}
