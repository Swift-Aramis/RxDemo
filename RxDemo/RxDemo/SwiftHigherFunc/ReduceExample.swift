//
//  ReduceExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 reduce 方法把数组元素组合计算为一个值，
 并且会接受一个初始值，
 这个初始值的类型可以和数组元素类型不同。
 */
class ReduceExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // **1**
        let prices = [20,30,40]
//        let sum = prices.reduce(0) { (a, b) -> Int in
//            return a + b
//        }
        let sum = prices.reduce(0, { $0 + $1 })
        print(sum)
        
        // 简化
        let sum2 = prices.reduce(0, +)
        print(sum2)
        
        // **2**
        let arr = ["Apple", "Orange", "Grape"]
        let str = arr.reduce("") {
            return $0 == "" ? $1 : $0 + "、" + $1
        }
        print(str)
        
        let str2 = arr.joined(separator: "、")
        print(str2)
    }

}
