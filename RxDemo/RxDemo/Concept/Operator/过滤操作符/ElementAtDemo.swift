//
//  ElementAtDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - elementAt
/**
 该方法实现只处理在指定位置的事件。
 */
class ElementAtDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4)
            .elementAt(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         3
         */
    }

}
