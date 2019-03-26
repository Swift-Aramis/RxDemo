//
//  Delegate.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

//MARK: - traditionalWay
class Delegate: UIViewController {

    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
}

extension Delegate: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("contentOffset: \(scrollView.contentOffset)")
    }
}

//MARK: - rxWay
class RxDelegate: UIViewController {
    
    let scrollView = UIScrollView()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.rx.contentOffset
            .subscribe(onNext: { (contentOffset) in
                 print("contentOffset: \(contentOffset)")
            })
            .disposed(by: disposeBag)
    }
}
