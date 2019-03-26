//
//  SingleDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 Single 是 Observable 的另外一个版本。
 不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
 
 发出一个元素，或一个 error 事件
 不会共享状态变化
 
 一个比较常见的例子就是执行 HTTP 请求，然后返回一个应答或错误。
 不过你也可以用 Single 来描述任何只有一个元素的序列。
 */
class SingleDemo: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        getRepo("ReactiveX/RxSwift").subscribe(onSuccess: { (json) in
            print("JSON: ", json)
        }, onError: { error in
            print("Error: ", error)
        }).disposed(by: disposeBag)
        
        /**
         你同样可以对 Observable 调用 .asSingle() 方法，将它转换为 Single。
         */
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
        numbers.asSingle()
    }
    
    //MARK: - 如何创建 Single
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: { (single) in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves), let result = json as? [String: Any] else {
                    single(.error(DataError.cantParseJSON))
                    return
                }
                
                single(.success(result))
            })
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        })
    }
    
    //与数据相关的错误类型
    enum DataError: Error {
        case cantParseJSON
    }
    

    /**
     
     public enum SingleEvent<Element> {
     /// One and only sequence element is produced. (underlying observable sequence emits: `.next(Element)`, `.completed`)
     case success(Element)
     
     /// Sequence terminated with an error. (underlying observable sequence emits: `.error(Error)`)
     case error(Swift.Error)
     }
     
     */
}
