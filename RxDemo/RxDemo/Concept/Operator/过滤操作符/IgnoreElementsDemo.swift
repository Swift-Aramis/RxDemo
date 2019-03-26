//
//  IgnoreElementsDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - ignoreElements
/**
 该操作符可以忽略掉所有的元素，只发出 error 或 completed 事件。
 */
class IgnoreElementsDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4)
            .ignoreElements()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        /**
         completed
         */
    }

}
