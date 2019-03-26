//
//  ErrorHandling.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - Error Handling - 错误处理
/**
 一旦序列里面产出了一个 error 事件，整个序列将被终止。RxSwift 主要有两种错误处理机制：
 retry - 重试
 catch - 恢复
 */
class ErrorHandling: UIViewController {

    typealias JSON = Any

    let rxJson: Observable<JSON> = Observable<JSON>.create { (observer) -> Disposable in
        return Disposables.create()
    }
    
    let disposeBag = DisposeBag()

    //MARK: - retry - 重试
    func retry() {
        /**
         retry 可以让序列在发生错误后重试：
         */
        // 请求 JSON 失败时，立即重试，
        // 重试 3 次后仍然失败，就将错误抛出
        rxJson
            .retry(3)
            .subscribe(onNext: { json in
                print("取得 JSON 成功: \(json)")
            }, onError: { error in
                print("取得 JSON 失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - retryWhen
    func retryWhen() {
        /**
         如果我们需要在发生错误时，经过一段延时后重试，那可以这样实现：
         */
        // 请求 JSON 失败时，等待 5 秒后重试
        // 重试 4 次后仍然失败，就将错误抛出
        let maxRetryCount = 4
        
        let retryDelay: Double = 5
        
        rxJson
            .retryWhen { (rxError: Observable<Error>) -> Observable<Int> in
                //                return Observable.timer(retryDelay, scheduler: MainScheduler.instance)
                
                /**
                 public func flatMapWithIndex<O: ObservableConvertibleType>(_ selector: @escaping (E, Int) throws -> O)
                 -> Observable<O.E> {
                 return enumerated().flatMap { try selector($0.element, $0.index) }
                 }
                 */
                return rxError.enumerated().flatMap({ (index, error) -> Observable<Int> in
                    guard index < maxRetryCount else {
                        return Observable.error(error)
                    }
                    return Observable.timer(retryDelay, scheduler: MainScheduler.instance)
                })
            }
            .subscribe(onNext: { json in
                print("取得 JSON 成功: \(json)")
            }, onError: { error in
                print("取得 JSON 失败: \(error)")
            })
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - catchError - 恢复
    func catchError() {
        /**
         catchError 可以在错误产生时，用一个备用元素或者一组备用元素将错误替换掉：
         */
        
        //1.当错误产生时，就返回一个空数组，于是就会显示一个空列表页。
        //        searchBar.rx.text.orEmpty
        //            ...
        //            .flatMapLatest { query -> Observable<[Repository]> in
        //                ...
        //                return searchGitHub(query)
        //>>>>>>>>>>>>>>>>>>>
        //                    .catchErrorJustReturn([])
        //>>>>>>>>>>>>>>>>>>>
        //            }
        //            ...
        //            .bind(to: ...)
        //                .disposed(by: disposeBag)
        
        //2.你也可以使用 catchError，当错误产生时，将错误事件替换成一个备选序列：
        // 先从网络获取数据，如果获取失败了，就从本地缓存获取数据
        
        //        let rxData: Observable<Data> = ...      // 网络请求的数据
        //        let cahcedData: Observable<Data> = ...  // 之前本地缓存的数据
        //
        //            rxData
        //                .catchError { _ in cahcedData }
        //                .subscribe(onNext: { date in
        //                    print("获取数据成功: \(date.count)")
        //                })
        //                .disposed(by: disposeBag)
    }
    
    //MARK: - Result
    /**
     如果我们只是想给用户错误提示，那要如何操作呢？
     */
    let updateUserInfoButton = UIButton()
    
    func result1() {
        // 当用户点击更新按钮时，
        // 就立即取出修改后的用户信息。
        // 然后发起网络请求，进行更新操作，
        // 一旦操作失败就提示用户失败原因
        
//        updateUserInfoButton.rx.tap
//            .withLatestFrom(rxUserInfo)
//            .flatMapLatest { userInfo -> Observable<Void> in
//                return update(userInfo)
//            }
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: {
//                print("用户信息更新成功")
//            }, onError: { error in
//                print("用户信息更新失败： \(error.localizedDescription)")
//            })
//            .disposed(by: disposeBag)
    }
    
    /**
     // 自定义一个枚举类型 Result
     public enum Result<T> {
     case success(T)
     case failure(Swift.Error)
     }
     */
    
    func result2() {
//        updateUserInfoButton.rx.tap
//            .withLatestFrom(rxUserInfo)
//            .flatMapLatest { userInfo -> Observable<Result<Void>> in
//                return update(userInfo)
//                    .map(Result.success)  // 转换成 Result
//                    .catchError { error in Observable.just(Result.failure(error)) }
//            }
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { result in
//                switch result {           // 处理 Result
//                case .success:
//                    print("用户信息更新成功")
//                case .failure(let error):
//                    print("用户信息更新失败： \(error.localizedDescription)")
//                }
//            })
//            .disposed(by: disposeBag)
        
        /**
         这样我们的错误事件被包装成了 Result.failure(Error) 元素，就不会终止整个序列。
         就算网络请求失败，整个订阅依然存在。如果用户再次点击更新按钮，也是能够发起网络请求进行更新操作的。
         */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
