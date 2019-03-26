//
//  Connectable_Observable.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/3.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
/**
 可连接的序列（Connectable Observable）：
 （1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect() 之后才会开始发送值。
 （2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。
 */
class Connectable_Observable: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// **普通序列的样例**
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        _ = interval.subscribe(onNext: { print("订阅1: \($0)") })
        
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         可以看到第一个订阅者订阅后，每隔 1 秒会收到一个值。
         而第二个订阅者 5 秒后才收到第一个值 0，所以两个订阅者接收到的值是不同步的。
         */
        /**
         0
         1
         2
         3
         4
         5
         
         0
         6
         1
         7
         */
    }
    
}

extension NSObject {
    
    /// 延迟执行
    ///
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - clousure: 延迟执行的闭包
    public func delay(_ delay: Double, clousure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            clousure()
        }
    }
}
