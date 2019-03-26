//
//  Notification.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

class Notification: UIViewController {

    var ntfObserver: NSObjectProtocol!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - traditionalWay
    func traditionalWay() {
        ntfObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil, queue: nil) { (notification) in
                print("Application Will Enter Foreground")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(ntfObserver)
    }

    //MARK: - rxWay
    func rxWay() {
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .subscribe(onNext: { (notification) in
               print("Application Will Enter Foreground")
            })
            .disposed(by: disposeBag)
    }
}
