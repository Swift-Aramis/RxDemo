//
//  FilterExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 filter 方法用于过滤元素，即筛选出数组元素中满足某种条件的元素。
 */
class FilterExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let prices = [20,30,40]
        let result = prices.filter({ $0 > 25 })
        print(result)
    }

}
