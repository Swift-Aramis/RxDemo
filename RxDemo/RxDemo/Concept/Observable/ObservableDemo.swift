//
//  Observable.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - Observable - 可被监听的序列
// 所有的事物都是序列
class ObservableDemo: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - 如何创建序列
        //创建序列最直接的方法就是调用 Observable.create
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
        
        //用这种方式来封装功能组件，例如，闭包回调
        
        typealias JSON = Any
        
        let json: Observable<JSON> =  Observable.create { (observer) -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "xxx")!), completionHandler: { (data, _, error) in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
                guard let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
//                    observer.onError(DataError.cantParseJSON)
                    observer.onError(error!)
                    return
                }
                
                observer.onNext(jsonObject)
                observer.onCompleted()
            })
            
            task.resume()
            // Disposables.create { task.cancel() } 说明如果数据绑定被清除（订阅被取消）的话，就取消网络请求。
            return Disposables.create { task.cancel() }
        }
        
        /**
         这里subscribe后面的onNext,onError, onCompleted 分别响应我们创建 json 时，构建函数里面的onNext,onError, onCompleted 事件。
         我们称这些事件为 Event:
         */
        json.subscribe(onNext: { (json) in
            print("取得 json 成功: \(json)")
        }, onError: { (error) in
            print("取得 json 失败 Error: \(error.localizedDescription)")
        }, onCompleted: {
            print("取得 json 任务成功完成")
        }).disposed(by: disposeBag)
        
    }
    
    //MARK: - Event - 事件
    /**
     next - 序列产生了一个新的元素
     error - 创建序列时产生了一个错误，导致序列终止
     completed - 序列的所有元素都已经成功产生，整个序列已经完成
     */
    public enum Event<Element> {
        case next(Element)
        case error(Swift.Error)
        case completed
    }
    
    //MARK: - 决策树
    
    //MARK: - 特征序列
    /**
     我们都知道 Swift 是一个强类型语言，而强类型语言相对于弱类型语言的一个优点是更加严谨。
     我们可以通过类型来判断出，实例有哪些特征。
     同样的在 RxSwift 里面 Observable 也存在一些特征序列，这些特征序列可以帮助我们更准确的描述序列。
     并且它们还可以给我们提供语法糖，让我们能够用更加优雅的方式书写代码，他们分别是：
     Single
     Completable
     Maybe
     Driver
     ControlEvent
     */
}
