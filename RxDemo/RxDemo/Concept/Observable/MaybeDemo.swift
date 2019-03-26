//
//  MaybeDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

/**
 Maybe 是 Observable 的另外一个版本。
 它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
 
 发出一个元素或者一个 completed 事件或者一个 error 事件
 不会共享状态变化
 
 如果你遇到那种可能需要发出一个元素，又可能不需要发出时，就可以使用 Maybe。
 */
class MaybeDemo: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateString()
            .subscribe(onSuccess: { element in
                print("Completed with element \(element)")
            }, onError: { error in
                print("Completed with an error \(error.localizedDescription)")
            }, onCompleted: {
                print("Completed with no element")
            })
            .disposed(by: disposeBag)
        
        //你同样可以对 Observable 调用 .asMaybe() 方法，将它转换为 Maybe。
        let numbers: Observable<Int> = Observable.create { (observer) -> Disposable in
            //在构建函数里面描述元素的产生过程
            //observer.onNext(0) 就代表产生了一个元素，他的值是 0
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            //最后，用 observer.onCompleted() 表示元素已经全部产生，没有更多元素了。
            observer.onCompleted()
            
            return Disposables.create()
        }
        numbers.asMaybe()
    }
    

    //MARK: - 如何创建 Maybe
    func generateString() -> Maybe<String> {
        return Maybe<String>.create(subscribe: { (maybe) in
            //成功并发出一个元素
            maybe(.success("RxSwift"))
            
            //成功但不发出任何元素
            maybe(.completed)
            
            //失败
//            maybe(.error(error))
            
            return Disposables.create()
        })
    }
    
}
