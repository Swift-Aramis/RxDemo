//
//  MapDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - 通过一个转换函数，将 Observable 的每个元素转换一遍
/**
 map 操作符将源 Observable 的每个元素应用你提供的转换方法，
 然后返回含有转换结果的 Observable。
 */

class MapDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        Observable.of(1, 2, 3)
            .map { $0 * 10 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         10
         20
         30
         */
    }
    
}
