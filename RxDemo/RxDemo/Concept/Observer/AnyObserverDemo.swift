//
//  AnyObserverDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 AnyObserver 可以用来描叙任意一种观察者。
 */
class AnyObserverDemo: UIViewController {

    let disposeBag = DisposeBag()

    let usernameValidOutlet = UILabel()
    let nameTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 打印网络请求结果：
        // rx origin
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: "xxx")!))
            .subscribe(onNext: { data in
                print("Data Task Success with count: \(data.count)")
            }, onError: { error in
                print("Data Task Error: \(error)")
            })
            .disposed(by: disposeBag)
        
        // rx AnyObserver
        let observer: AnyObserver<Data> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print("Data Task Success with count: \(data.count)")
            case .error(let error):
                print("Data Task Error: \(error)")
            default:
                break
            }
        }
        
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: "xxx")!))
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        
        //用户名提示语是否隐藏：
        // rx origin
        let userNameValid = nameTF.rx.text.orEmpty
            .map { $0.count >= 6 }
            .share(replay: 1)
        
        userNameValid.bind(to: usernameValidOutlet.rx.isHidden).disposed(by: disposeBag)
   
        // rx AnyObserver
        let userObserver: AnyObserver<Bool> = AnyObserver { [weak self] (event) in
            switch event {
            case .next(let isHidden):
                self?.usernameValidOutlet.isHidden = isHidden
            default:
                break
            }
        }
        
        userNameValid.bind(to: userObserver).disposed(by: disposeBag)
        
    }


}
