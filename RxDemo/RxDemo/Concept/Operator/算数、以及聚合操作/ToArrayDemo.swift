//
//  ToArrayDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/3.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 算数、以及聚合操作（Mathematical and Aggregate Operators）
 */

//MARK: - toArray
/**
 该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束。
 */
class ToArrayDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         [1, 2, 3]
         */
    }

}
