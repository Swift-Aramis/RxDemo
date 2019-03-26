//
//  BinderDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

/**
 Binder 主要有以下两个特征
 
 不会处理错误事件
 确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
 
 一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
 */
class BinderDemo: UIViewController {

    let disposeBag = DisposeBag()
    
    let usernameValidOutlet = UILabel()
    let nameTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userNameValid = nameTF.rx.text.orEmpty
            .map { $0.count >= 6 }
            .share(replay: 1)
        
        let userObserver: AnyObserver<Bool> = AnyObserver { [weak self] (event) in
            switch event {
            case .next(let isHidden):
                self?.usernameValidOutlet.isHidden = isHidden
            default:
                break
            }
        }
        
        userNameValid.bind(to: userObserver).disposed(by: disposeBag)
        
        // >>>>>>改进>>>>>>
        /**
         Binder 可以只处理 next 事件，
         并且保证响应 next 事件的代码一定会在给定 Scheduler 上执行，
         这里采用默认的 MainScheduler。
         */
        let observer: Binder<Bool> = Binder(usernameValidOutlet) {(view, isHidden) in
            view.isHidden = isHidden
        }
        
        userNameValid.bind(to: observer).disposed(by: disposeBag)
        
    }
    
}
