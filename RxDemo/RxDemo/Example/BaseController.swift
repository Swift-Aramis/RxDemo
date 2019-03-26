//
//  BaseController.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/25.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

}
