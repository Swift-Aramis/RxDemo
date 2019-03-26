//
//  FlatMapExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 1.flatMap 方法同 map 方法比较类似，
 只不过它返回后的数组中不存在 nil（自动把 nil 给剔除掉），同时它会把 Optional 解包。
 
 public func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]

 2.flatMap 还能把数组中存有数组的数组（二维数组、N维数组）一同打开变成一个新的数组。
 
 */
class FlatMapExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // **1**
        let arr = ["Apple", "Orange", "Grape", ""]
        // map
        let arr1 = arr.map { (a) -> Int? in
            let length = a.count
            guard length > 0 else { return nil }
            return length
        }
        print("arr1:\(arr1)")
        
        //flatMap
        /**
         compactMap: 当后面的闭包中返回Optional的时候，在Swift 4.1中应该使用compactMap代替map。
         */
        let arr2 = arr.compactMap { (a) -> Int? in
            let length = a.count
            guard length > 0 else { return nil }
            return length
        }
        print("arr2:\(arr2)")
        
        let arrT = ["Apple", "Orange", "Grape"]
        let arr3 = arrT.compactMap { (a) -> Int in
            let length = a.count
            return length
        }
        print("arr3:\(arr3)")
        
        
        // **2**
        let arrE = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let arrE1 = arrE.map{ $0 }   // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        print("arrE1:\(arrE1)")

        // -> Sequence
        let arrE2 = arrE.flatMap{ $0 } // [1, 2, 3, 4, 5, 6, 7, 8, 9]
        print("arrE2:\(arrE2)")
        

    }
}
