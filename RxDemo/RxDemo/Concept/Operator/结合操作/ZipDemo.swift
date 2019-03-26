
//
//  ZipDemp.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - zip
/**
 该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
 而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
 */

/**
 zip 常常用在整合网络请求上。
 比如我们想同时发送两个请求，只有当两个请求都成功后，再将两者的结果整合起来继续往下处理。这个功能就可以通过 zip 来实现
 */
class ZipDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.zip(subject1, subject2) {
            "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
        
        /**
         1A
         2B
         3C
         4D
         */
        
        
        //第一个请求
        let userRequest: Observable<User> = API.getUser("me")
        
        //第二个请求
        let friendsRequest: Observable<Friends> = API.getFriends("me")
        
        //将两个请求合并处理
        Observable.zip(userRequest, friendsRequest) {
            user, friends in
            //将两个信号合并成一个信号，并压缩成一个元组返回（两个信号均成功）
            return (user, friends)
            }
            .observeOn(MainScheduler.instance) //加这个是应为请求在后台线程，下面的绑定在前台线程。
            .subscribe(onNext: { (user, friends) in
                //将数据绑定到界面上
                //.......
            })
            .disposed(by: disposeBag)
    }

}

struct Friends {
    
}

class API: NSObject {
    
    static func getUser(_ name: String) -> Observable<User> {
        return Observable<User>.empty()
    }
    
    static func getFriends(_ name: String) ->  Observable<Friends> {
        return  Observable<Friends>.empty()
    }
}
