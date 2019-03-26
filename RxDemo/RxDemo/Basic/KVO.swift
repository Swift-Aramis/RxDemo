//
//  KVO.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

class User: NSObject {
    @objc let name = ""
}

class KVO: UIViewController {

    var user = User()

    private var observerContext = 0
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - traditionalWay
    func traditionalWay() {
        user.addObserver(self, forKeyPath: #keyPath(User.name), options: [.new, .initial], context: &observerContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &observerContext {
            let newValue = change?[.newKey] as? String
            print(newValue ?? "--")
            print("do something with newValue")
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        user.removeObserver(self, forKeyPath: #keyPath(User.name))
    }
    
    //MARK: - rxWay
    func rxWay() {
        user.rx.observe(String.self, #keyPath(User.name))
            .subscribe(onNext: { newValue in
                print("do something with newValue")
            })
            .disposed(by: disposeBag)
    }
}
