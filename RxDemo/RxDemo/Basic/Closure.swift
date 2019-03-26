//
//  Closure.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

class Closure: UIViewController {

    let url = URL(string: "")
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - traditionalWay
    func traditionalWay() {
        URLSession.shared.dataTask(with: URLRequest(url: url!)) {
            (data, response, error) in
            guard error == nil else {
                print("Data Task Error: \(error!)")
                return
            }
            
            guard let data = data else {
                print("Data Task Error: unknown")
                return
            }
            
            print("Data Task Success with count: \(data.count)")
        }.resume()
    }
    
    //MARK: - rxWay
    func rxWay() {
        URLSession.shared.rx.data(request: URLRequest(url: url!))
            .subscribe(onNext: { (data) in
                print("Data Task Success with count: \(data.count)")
            }, onError: { (error) in
                print("Data Task Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
