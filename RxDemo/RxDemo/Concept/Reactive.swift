//
//  Reactive.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

//MARK: - 函数式编程 -> 函数响应式编程
class Reactive: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func functionalReactive() {
        // 假设用户在进入页面到离开页面期间，总共点击按钮 3 次
        // 按钮点击序列
        let taps: Array<Void> = [(), (), ()]
        
        // 每次点击后弹出提示框
        taps.forEach {
            showAlert()
        }
        
        //可被监听的序列Observable<Element>
        // 按钮点击序列
        let rxTaps: Observable<Void> = button.rx.tap.asObservable()
        
        // 每次点击后弹出提示框
        rxTaps.subscribe(onNext: { [weak self] _ in
            self?.showAlert()
        })
        //MARK: - 响应式编程
        /**
         这里 rxTaps 就是按钮点击事件的序列。
         然后我们通过弹出提示框，来对每一次点击事件做出响应。
         这种编程方式叫做响应式编程。
         */
        
        //MARK: - 函数响应式编程
        /**
         我们结合函数式编程以及响应式编程就得到了函数响应式编程：
         我们通过不同的构建函数，来创建所需要的数据序列。
         最后通过适当的方式来响应这个序列。
         这就是函数响应式编程。
         */
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
