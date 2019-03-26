//
//  ConceptCore.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - RxSwift 核心
/**
 Observable - 产生事件
 Observer - 响应事件
 Operator - 创建变化组合事件
 Disposable - 管理绑定（订阅）的生命周期
 Schedulers - 线程队列调配
 */

class ConceptCore: UIViewController {

    let usernameOutlet = UITextField()
    let passwordValidOutlet = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Observable<String> 产生事件
        let text = usernameOutlet.rx.text.orEmpty.asObservable()
        
        // Observable<Bool>
        let passwordValid = text
            // Operator 组合事件
            .map { $0.count >= 6 }
        
        // Observer<Bool> 响应事件
        let observer = passwordValidOutlet.rx.isHidden
        
        // Disposable 管理生命周期
        let disposable = passwordValid
            // Scheduler 用于控制任务在哪个线程队列运行
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .bind(to: observer)
        
        // 取消绑定，你可以在退出页面时取消绑定
        disposable.dispose()
    }
    
}
