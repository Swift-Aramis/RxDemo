//
//  SchedulersDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - Schedulers - 调度器
/**
 Schedulers 是 Rx 实现多线程的核心模块，它主要用于控制任务在哪个线程或队列运行。
 */
class SchedulersDemo: UIViewController {

    var data: Data?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 后台取得数据，主线程处理结果
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: URL(string: "xxx")!)
            DispatchQueue.main.async {
                self.data = data
            }
        }
        
        let rxData: Observable<Data> = Observable<Data>.create { (observer) -> Disposable in
            return Disposables.create()
        }
        rxData
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] data in
                self?.data = data
            })
            .disposed(by: disposeBag)
        
        /**
         我们用 subscribeOn 来决定数据序列的构建函数在哪个 Scheduler 上运行。
         
         我们用 observeOn 来决定在哪个 Scheduler 监听这个数据序列。
         */
        
        /**
         MainScheduler 代表主线程。
         如果你需要执行一些和 UI 相关的任务，就需要切换到该 Scheduler 运行。
         
         SerialDispatchQueueScheduler 抽象了串行 DispatchQueue。
         如果你需要执行一些串行任务，可以切换到这个 Scheduler 运行。
         
         ConcurrentDispatchQueueScheduler 抽象了并行 DispatchQueue。
         如果你需要执行一些并发任务，可以切换到这个 Scheduler 运行。
         
         OperationQueueScheduler 抽象了 NSOperationQueue。
         它具备 NSOperationQueue 的一些特点，
         例如，你可以通过设置 maxConcurrentOperationCount，来控制同时执行并发任务的最大数量。
         */
    }

}
