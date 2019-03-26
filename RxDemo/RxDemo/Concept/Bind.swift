//
//  Bind.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

//MARK: - 数据绑定（订阅）
class Bind: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         在 RxSwift 里有一个比较重要的概念就是数据绑定（订阅）。
         就是指将可被监听的序列绑定到观察者上：
         */
        let imageView = UIImageView()
        let image: UIImage = UIImage(named: "xxx")!
        imageView.image = image
        
        /**
         将一个图片序列 “同步” 到imageView上。
         这个序列里面的图片可以是异步产生的。
         这里定义的 image 就是（可被监听的序列），
         imageView.rx.image就是（观察者）。
         而这种 “同步机制” 就是数据绑定（订阅）。
         */
        
        let rxImg: Observable<UIImage> = Observable<UIImage>.empty()
        _ = rxImg.bind(to: imageView.rx.image)
    }

}
