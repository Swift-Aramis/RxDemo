//
//  VariableDemo.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/26.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
/**
 在 Swift 中我们经常会用 var 关键字来声明变量。
 RxSwift 提供的 Variable 实际上是 var 的 Rx 版本，你可以将它看作是 RxVar。
 */
struct Model {
}

class VariableDemo: UIViewController {

    //MARK: - 使用 var：
    var model: Model? = nil {
        didSet {
            updateUI(with: model)
        }
    }
    
    func updateUI(with model: Model?) {
        
    }
    
    func getModel() -> Model {
        return Model()
    }
    
    //MARK: - 使用 Variable：
    let rxModel: Variable<Model?> = Variable(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = getModel()
        
        // >>>>>>
        let disposeBag = DisposeBag()

        rxModel.asObservable().subscribe(onNext: { [weak self] (model) in
            self?.updateUI(with: model)
        }).disposed(by: disposeBag)
        
        rxModel.value = getModel()
    }


    

}
