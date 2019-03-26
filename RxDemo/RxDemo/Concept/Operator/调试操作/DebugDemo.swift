//
//  DebugDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class DebugDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let disposeBag = DisposeBag()
        
        //MARK: - debug
        /**
         我们可以将 debug 调试操作符添加到一个链式步骤当中，这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试。
         debug() 方法还可以传入标记参数，这样当项目中存在多个 debug 时可以很方便地区分出来。
         */
        Observable.of("2", "3")
            .startWith("1")
            .debug()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        Observable.of("2", "3")
            .startWith("1")
            .debug("调试1")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        //MARK: - RxSwift.Resources.total (需在podfile进行相应配置)
        /**
         通过将 RxSwift.Resources.total 打印出来，我们可以查看当前 RxSwift 申请的所有资源数量。这个在检查内存泄露的时候非常有用。
         */
//        print(RxSwift.Resources.total)
//
//        print(RxSwift.Resources.total)
//
//        Observable.of("BBB", "CCC")
//            .startWith("AAA")
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
//
//        print(RxSwift.Resources.total)
        
        
    }

}
