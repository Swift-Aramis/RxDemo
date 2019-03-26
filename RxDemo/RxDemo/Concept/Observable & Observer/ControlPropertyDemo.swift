//
//  ControlPropertyDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 ControlProperty 专门用于描述 UI 控件属性的，它具有以下特征：
 
 不会产生 error 事件
 一定在 MainScheduler 订阅（主线程订阅）
 一定在 MainScheduler 监听（主线程监听）
 共享状态变化
 */
class ControlPropertyDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
