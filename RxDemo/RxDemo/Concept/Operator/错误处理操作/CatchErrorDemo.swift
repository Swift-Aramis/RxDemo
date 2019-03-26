//
//  CatchErrorDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
//MARK: - catchError
/**
 该方法可以捕获 error，并对其进行处理。
 同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。
 */
class CatchErrorDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let disposeBag = DisposeBag()
        
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = Observable.of("1", "2", "3")
        
        sequenceThatFails.catchError {
                print("Error:", $0)
                return recoverySequence
            }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }
    
    /**
     a
     b
     c
     Error: A
     1
     2
     3
     */

}
