//
//  MapExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 map 方法获取一个闭包表达式作为其唯一参数。
 数组中的每一个元素调用一次该闭包函数，并返回该元素所映射的值。
 简单说就是数组中每个元素通过某个方法进行转换，最后返回一个新的数组。

 public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
 */
class MapExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // **1**
        let prices = [10, 20, 30]
        let strs = prices.map { (i) -> String in
            return "$\(i)"
        }
        print(strs)

        let strs2 = prices.map({"$\($0)"})
        print(strs2)
        
        // **2**
        let values = [4, 6, 9]
        let squares = values.map({ $0 * $0 })
        print(squares)
    }
    

    
}
