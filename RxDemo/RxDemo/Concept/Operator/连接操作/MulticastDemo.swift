//
//  MulticastDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/7.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 multicast 方法同样是将一个正常的序列转换成一个可连接的序列。
 同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
 */
class MulticastDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建一个Subject（后面的multicast()方法中传入）
        let subject = PublishSubject<Int>()
        
        //这个Subject的订阅
        _ = subject
            .subscribe(onNext: { print("Subject: \($0)") })
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .multicast(subject)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
    }

}
