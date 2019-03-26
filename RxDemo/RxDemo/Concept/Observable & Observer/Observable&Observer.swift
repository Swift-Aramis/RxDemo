
//
//  Observable&Observer.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - Observable & Observer 既是可被监听的序列也是观察者
/**
 在我们所遇到的事物中，有一部分非常特别。它们既是可被监听的序列也是观察者。
 
 他们之间最大的区别只是在于：当一个新的订阅者刚订阅它的时候，能不能收到 Subject 以前发出过的旧 Event，如果能的话又能收到多少个。
 */

/**
 Subjects 既是订阅者，也是 Observable：
 说它是订阅者，是因为它能够动态地接收新的值。
 说它又是一个 Observable，是因为当 Subjects 有了新的值之后，就会通过 Event 将新值发出给他的所有订阅者。
 
 一共有四种 Subjects，分别为：PublishSubject、BehaviorSubject、ReplaySubject、Variable。他们之间既有各自的特点，也有相同之处：
 首先他们都是 Observable，他们的订阅者都能收到他们发出的新的 Event。
 直到 Subject 发出 .complete 或者 .error 的 Event 后，该 Subject 便终结了，同时它也就不会再发出 .next 事件。
 对于那些在 Subject 终结后再订阅他的订阅者，也能收到 subject 发出的一条 .complete 或 .error 的 event，告诉这个新的订阅者它已经终结了。
 
 他们之间最大的区别只是在于：当一个新的订阅者刚订阅它的时候，能不能收到 Subject 以前发出过的旧 Event，如果能的话又能收到多少个。
 */
class Observable_Observer: UIViewController {

    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         例如：
         textField的当前文本。
         它可以看成是由用户输入，而产生的一个文本序列。
         也可以是由外部文本序列，来控制当前显示内容的观察者：
         */
        
        // 作为可被监听的序列
        let observable = textField.rx.text
        _ = observable.subscribe(onNext: { [weak self] text in self?.show(text: text) })
        
        // 作为观察者
        let observer = textField.rx.text
        let text: Observable<String?> = textField.rx.text.asObservable()
        _ = text.bind(to: observer)
    }
    
    func show(text: String?) {
        
    }

}
