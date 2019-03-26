//
//  ZipExample.swift
//  RxDemo
//
//  Created by 提运佳 on 2019/1/2.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 其作用是将两个序列的元素，一一对应合并生成一个新序列。
 */
class ZipExample: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // **1** 将两个数组合并成一个新的元组数组
        //1.使用 zip 结合 map 来合并生成新数组。注意：zip 函数生成的新序列个数为原始序列的最小值。
        let a = [1, 2, 3, 4, 5]
        let b = ["a", "b", "c", "d"]
        let c = zip(a, b).map({ $0 })
        print(c)
        
        //2.由于 zip 过程中较短的一个序列结束后整个操作就会停止，我们这里还可以使用单向区间。
        let d = zip(1..., b).map({ $0 })
        print(d)
        
        // **2** 通过键值序列创建字典
        //1.将两个数组合并成一个字典。
        let names = ["Apple", "Pear"]
        let prices = [7, 6]
        let dict = Dictionary(uniqueKeysWithValues: zip(names, prices))
        print(dict)
        
        //2.zip 配合速记 + 可以用来解决重复键的问题。比如下面将数组转为字典，字典键为数组元素值，字典值为该元素出现的次数。
        let array = ["Apple", "Pear", "Pear", "Orange"]
        let dic = Dictionary(zip(array, repeatElement(1, count: array.count)), uniquingKeysWith: +)
        print(dic)
        
        // **3** 将两个数组合并成一个新数组
        /**
         我们知道 flatMap 函数还能把数组中存有数组的数组（二维数组、N维数组）一同打开变成一个新的数组，不过新数组里元素的顺序是根据原数组顺序一个接着一个的。
         而配合 zip 可以让两个数组元素间隔地插入。下面代码分别比较这两种方式。
         */
        let a1 = ["a", "b", "c", "d"]
        let b1 = ["A", "B", "C", "D"]
        let c1 = [a, b].compactMap({ $0 })
        print("c1: \(c1)")
        
        let d1 = zip(a1, b1).flatMap({ [$0, $1] })
        print("d1：\(d1)")
        
        // **4** 根据 String 数组生成对应的按钮数组
        /**
         相当于titles.count for循环
         */
        let titles = ["按钮1", "按钮2", "按钮3"]
        //1->元组数组
        //2->遍历数组,转换数组
        let buttons = zip(0..., titles).map { (i, title) -> UIButton in
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.tag = i
            return button
        }
        
        // **5** 将按钮数组里的按钮设置成对应颜色数组里的颜色
        //1->元组数组
        //2->遍历数组
        let colors = [UIColor]()
        zip(buttons, colors).forEach { (button, color) in
            button.backgroundColor = color
        }
        
        // 简写
        zip(buttons, colors).forEach {
            $0.0.backgroundColor = $0.1
        }
        
    }

}
