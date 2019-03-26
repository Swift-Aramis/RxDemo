//
//  TakeDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - take
/**
 仅仅从 Observable 中发出头 n 个元素
 通过 take 操作符你可以只发出头 n 个元素。并且忽略掉后面的元素，直接结束序列。
 */

class TakeDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
            .take(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         🐱
         🐰
         🐶
         */
    }
}
