//
//  DistinctUntilChangedDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 该操作符用于过滤掉连续重复的事件。
 */
class DistinctUntilChangedDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        Observable.of(1,2,3,1,1,4).distinctUntilChanged().subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        /**
         1
         2
         3
         1 ==> 连续重复的事件只执行一次
         4
         */
    }

}
