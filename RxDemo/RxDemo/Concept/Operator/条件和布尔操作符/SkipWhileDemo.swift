//
//  SkipWhileDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - skipWhile
/**
 该方法用于跳过前面所有满足条件的事件。
 一旦遇到不满足条件的事件，之后就不会再跳过了。
 */
class SkipWhileDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        
        Observable.of(2, 3, 4, 5, 6)
            .skipWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         4
         5
         6
         */
    }

}
