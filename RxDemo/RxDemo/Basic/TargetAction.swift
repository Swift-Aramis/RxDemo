//
//  TargetAction.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

class TargetAction: UIViewController {

    let button = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - traditionalWay
    func traditionalWay() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("button Tapped")
    }
    
    //MARK: - rxWay
    func rxWay() {
        button.rx.tap
            .subscribe(onNext: {
                print("button Tapped")
            })
            .disposed(by: disposeBag)
    }

}
