//
//  FilterDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 过滤操作符（Filtering Observables）
 
 过滤操作指的是从源 Observable 中选择特定的数据发送。
 */

//MARK: - filter
/**
 该操作符就是用来过滤掉某些不符合要求的事件。
 */
class FilterDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        
        Observable.of(2, 30, 22, 5, 60, 3, 40 ,9)
            .filter {
                $0 > 10
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
}
