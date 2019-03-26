//
//  ScanDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - 持续的将 Observable 的每一个元素应用一个函数，然后发出每一次函数返回的结果
/**
 scan 操作符将对第一个元素应用一个函数，将结果作为第一个元素发出。然后，将结果作为参数填入到第二个元素的应用函数中，创建第二个元素。以此类推，直到遍历完全部的元素。
 
 这种操作符在其他地方有时候被称作是 accumulator。(累加器)
 */
class ScanDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        Observable.of(10, 100, 1000)
            .scan(1) { (aggregateValue, newValue) in
                aggregateValue + newValue
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         11
         111
         1111
         */
    }
    
}
