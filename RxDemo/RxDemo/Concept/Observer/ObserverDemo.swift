//
//  ObserverDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - Observer - 观察者
/**
 观察者 是用来监听事件，然后它需要这个事件做出响应。
 例如：弹出提示框就是观察者，它对点击按钮这个事件做出响应。
 */
class ObserverDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()
        let rxTap: Observable<Void> = button.rx.tap.asObservable()

        /**
         创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述，事件发生时，需要如何做出响应。
         而观察者就是由后面的 onNext，onError，onCompleted的这些闭包构建出来的。
         */
        _ = rxTap.subscribe(onNext: { [weak self] _ in
                self?.showAlert()
            }, onError: { (error) in
                print("发生错误： \(error.localizedDescription)")
            }, onCompleted: {
                print("任务完成")
            })
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}
