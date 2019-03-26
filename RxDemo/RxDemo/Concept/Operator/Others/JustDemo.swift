//
//  JustDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 创建 Observable 发出唯一的一个元素
 
 just 操作符将某一个元素转换为 Observable。
 */
class JustDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let id = Observable.just(0)
        
        // >>>>>等价>>>>>
        let ID = Observable<Int>.create { (observer) in
            observer.onNext(0)
            observer.onCompleted()
            return Disposables.create()
        }
        
        
    }

}
