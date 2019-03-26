//
//  GroupByDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//MARK: - groupBy
/**
 groupBy 操作符将源 Observable 分解为多个子 Observable，然后将这些子 Observable 发送出来。
 也就是说该操作符会将元素通过某个键进行分组，然后将分组后的元素序列以 Observable 的形态发送出来。
 */
class GroupByDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        //将奇数偶数分成两组
        Observable<Int>.of(0, 1, 2, 3, 4, 5).groupBy { (element) -> String in
            return element % 2 == 0 ? "偶数" : "奇数"
            }
            .subscribe { (event) in
                switch event {
                case .next(let group):
                    group.asObservable().subscribe(onNext: { (event) in
                        print("key：\(group.key)    event：\(event)")
                    }).disposed(by: disposeBag)
                default:
                    break
                }
        }.disposed(by: disposeBag)
    }
    

}
