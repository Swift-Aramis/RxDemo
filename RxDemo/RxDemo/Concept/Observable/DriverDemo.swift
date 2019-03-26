//
//  DriverDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

/**
 在上文中，我介绍了 RxSwift 提供的一些特征序列（Traits）：Single、Completable、Maybe。
 接下来的文章我会接着介绍另外两个特征序列：Driver、ControlEvent。
 更准确说，这两个应该算是 RxCocoa traits，因为它们是专门服务于 RxCocoa 工程的。
 */

/**
 */

/**
 Driver（司机？） 是一个精心准备的特征序列。
 它主要是为了简化 UI 层的代码。
 不过如果你遇到的序列具有以下特征，你也可以使用它：
 
 不会产生 error 事件
 一定在 MainScheduler 监听（主线程监听）
 共享状态变化
 
 这些都是驱动 UI 的序列所具有的特征。
 */

/**
 1.Driver 最常使用的场景应该就是需要用序列来驱动应用程序的情况了，比如：
 通过 CoreData 模型驱动 UI
 使用一个 UI 元素值（绑定）来驱动另一个 UI 元素值
 
 2.与普通的操作系统驱动程序一样，如果出现序列错误，应用程序将停止响应用户输入。
 3.在主线程上观察到这些元素也是极其重要的，因为 UI 元素和应用程序逻辑通常不是线程安全的。
 4.此外，使用构建 Driver 的可观察的序列，它是共享状态变化。
 */

class DriverDemo: UIViewController {
    
    /**
     这个是官方提供的样例，大致的意思是根据一个输入框的关键字，来请求数据，
     然后将获取到的结果绑定到另一个 Label
     和 TableView 中。
     */
    let disposeBag = DisposeBag()
    
    let query = UITextField()
    let resultCount = UILabel()
    let resultsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func normalObservableDemo() {
        
        let results = query.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)//在主线程中操作，0.3秒内值若多次改变，取最后一次
            .flatMapLatest { query in //筛选出空值, 拍平序列
                self.fetchAutoCompleteItems(query!) //向服务器请求一组结果
        }
        
        //将返回的结果绑定到用于显示结果数量的label上
        results
            .map { "\($0.count)" }
            .bind(to: resultCount.rx.text)
            .disposed(by: disposeBag)
        
        //将返回的结果绑定到tableView上
        results.bind(to: resultsTableView.rx.items(cellIdentifier: "Cell")) { (_, result, cell) in
            cell.textLabel?.text = "\(result)"
        }.disposed(by: disposeBag)
        
        /**
         这个代码存在如下 3 个问题：
         1.如果 fetchAutoCompleteItems 的序列产生了一个错误（网络请求失败），这个错误将取消所有绑定。此后用户再输入一个新的关键字时，是无法发起新的网络请求。
         2.如果 fetchAutoCompleteItems 在后台返回序列，那么刷新页面也会在后台进行，这样就会出现异常崩溃。
         3.返回的结果被绑定到两个 UI 元素上。那就意味着，每次用户输入一个新的关键字时，就会分别为两个 UI 元素发起 HTTP 请求，这并不是我们想要的结果。
         */
    }
    
    /// 修改后
    func safeObservableDemo() {
        let results = query.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)//在主线程中操作，0.3秒内值若多次改变，取最后一次
            .flatMapLatest { query in //筛选出空值, 拍平序列
                self.fetchAutoCompleteItems(query!) //向服务器请求一组结果
                    .observeOn(MainScheduler.instance) //将返回结果切换到到主线程上
                    .catchErrorJustReturn([]) //错误被处理了，这样至少不会终止整个序列
        }.share(replay: 1)
    }
    
    /// 使用 Driver 来实现的话就简单了
    func driverDemo() {
        /**
         代码讲解：
         （1）首先我们使用 asDriver 方法将 ControlProperty 转换为 Driver。
         （2）接着我们可以用 .asDriver(onErrorJustReturn: []) 方法将任何 Observable 序列都转成 Driver，因为我们知道序列转换为 Driver 要他满足 3 个条件：
                 不会产生 error 事件
                 一定在主线程监听（MainScheduler）
                 共享状态变化（shareReplayLatestWhileConnected）
         
             asDriver(onErrorJustReturn: []) 相当于以下代码：
         
             let safeSequence = xs
             .observeOn(MainScheduler.instance)       // 主线程监听
             .catchErrorJustReturn(onErrorJustReturn) // 无法产生错误
             .share(replay: 1, scope: .whileConnected)// 共享状态变化
             return Driver(raw: safeSequence)           // 封装
         
         （3）同时在 Driver 中，框架已经默认帮我们加上了 shareReplayLatestWhileConnected，所以我们也没必要再加上"replay"相关的语句了。
         （4）最后记得使用 drive 而不是 bindTo
         */
        
        let results = query.rx.text.asDriver() // 将普通序列转换为 Driver
            .throttle(0.3)
            .flatMapLatest { query in
            self.fetchAutoCompleteItems(query!).asDriver(onErrorJustReturn: []) // 仅仅提供发生错误时的备选返回值
        }
        
        //将返回的结果绑定到显示结果数量的label上
        //使用 drive 而不是 bindTo
        results.map { "\($0.count)" }.drive(resultCount.rx.text).disposed(by: disposeBag)
        
        //将返回的结果绑定到tableView上
        //同样使用 drive 而不是 bindTo
        results
            .drive(resultsTableView.rx.items(cellIdentifier: "Cell")) { (_, result, cell) in
            cell.textLabel?.text = "\(result)"
        }.disposed(by: disposeBag)
        
        /**
         由于 drive 方法只能被 Driver 调用。
         这意味着，如果代码存在 drive，那么这个序列不会产生错误事件并且一定在主线程监听。
         这样我们就可以安全的绑定 UI 元素。
         */
    }
    
    func fetchAutoCompleteItems(_ query: String) -> Observable<[String]> {
        return Observable<[String]>.empty()
    }
}
