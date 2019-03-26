//
//  SingleDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//MARK: - single
/**
 限制只发送一次事件，或者满足条件的第一个事件。
 如果存在有多个事件或者没有事件都会发出一个 error 事件。
 如果只有一个事件，则不会发出 error 事件。
 */
class Single_Demo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()

        Observable.of(1,2,3,4)
            .single { $0 == 2 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         2
         */
        
        Observable.of("A", "B", "C", "D")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         A
         === send error ===
         */
        
       
    }

}
