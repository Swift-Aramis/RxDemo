//
//  ChainedExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 链式组合
 */
class ChainedExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.将数组中大于 7 的所有数字进行求和操作。
        let marks = [4,5,8,2,9,7]
        let totalPass = marks.filter({ $0 > 7 }).reduce(0, +)//17
        print(totalPass)
        
        // 2.对某一个数组里面的数字进行平方操作然后再筛选出偶数值。
        let evenSquares = marks.map({ $0 * $0 }).filter({ $0 % 2 == 0 })//[16, 64, 4]
        print(evenSquares)
    }
    
}
