//
//  CompletableDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 Completable 是 Observable 的另外一个版本。
 不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
 
 发出零个元素
 发出一个 completed 事件或者一个 error 事件
 不会共享状态变化
 
 Completable 适用于那种你只关心任务是否完成，而不需要在意任务返回值的情况。
 它和 Observable<Void> 有点相似。
 
 Completable 和 Observable<Void> 有点类似。适用于那些只关心任务是否完成，而不需要在意任务返回值的情况。
 比如：在程序退出时将一些数据缓存到本地文件，供下次启动时加载。像这种情况我们只关心缓存是否成功。
 */
class CompletableDemo: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cacheLocally().subscribe(onCompleted: {
            print("Completed with no error")
        }, onError: { error in
            print("Completed with an error: \(error.localizedDescription)")
        }).disposed(by: disposeBag)
    }
    
    //MARK: - 如何创建 Completable
    func cacheLocally() -> Completable {
        return Completable.create(subscribe: { (completable) in
            // Store some data locally
            // ...
            let success = (arc4random() % 2) == 0
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create()
            }
            
            completable(.completed)
            return Disposables.create()
        })
    }
    
    //与缓存相关的错误类型
    enum CacheError: Error {
        case failedCaching
    }

    /**
     public enum CompletableEvent {
         case error(Swift.Error)
         case completed
     }
     
     completed - 产生完成事件
     error - 产生一个错误
     */
}
