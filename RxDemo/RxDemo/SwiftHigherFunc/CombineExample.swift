//
//  CombineExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 组合使用
 */
class CombineExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.flatMap 配合 filter 将多维整型数组里面的偶数筛选出来并且组合成了一个一维数组。
        let collections = [[5,2,7],[4,8],[9,1,3]]
        let onlyEven = collections.flatMap {
            $0.filter({ $0 % 2 == 0 })
        }
        print(onlyEven)
        
        // 2.map 配合 reduce 计算二维数组里每个分组的总和。
        let sums = collections.map {
            $0.reduce(0, +)
        }
        print(sums)
        
    }

}
