//
//  Dependency.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

//MARK: - 多个任务之间有依赖关系
class Dependency: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - traditionalWay
    func traditionalWay() {
        /// 通过用户名和密码获取用户信息
        Api.token(userName: "Swift_Aramis", password: "123456", success: { (token) in
            
            Api.userInfo(token: token, success: { (userInfo) in
                print("获取用户信息成功: \(userInfo)")
            }, failure: { error in
                print("获取用户信息失败: \(error)")
            })
        }, failure: { error in
            print("获取用户信息失败: \(error)")
        })
    }
    
    //MARK: - rxWay
    func rxWay() {
        RxApi.token(userName: "Swift_Aramis", password: "123456")
            .flatMapLatest(RxApi.userInfo).subscribe(onNext: { (userInfo) in
                print("获取用户信息成功: \(userInfo)")
            }, onError: { (error) in
                print("获取用户信息失败: \(error)")
            })
            .disposed(by: disposeBag)
    }

}

//MARK: - traditionalWay
struct UserInfo {
}

/// 用回调的方式封装接口
enum Api {
    /// 通过用户名密码取得一个 token
    static func token(userName: String, password: String,
                      success: (String) -> Void,
                      failure: (Error) -> Void) {
        //...
    }
    
    /// 通过 token 取得用户信息
    static func userInfo(token: String,
                         success: (UserInfo) -> Void,
                         failure: (Error) -> Void) {
        //...
    }
}


//MARK: - rxWay
enum RxApi {
    /// 通过用户名密码取得一个 token
    static func token(userName: String, password: String) -> Observable<String> {
        //...
        return Observable<String>.empty()
    }
    
    /// 通过 token 取得用户信息
    static func userInfo(token: String) -> Observable<UserInfo> {
        //...
        return Observable<UserInfo>.empty()
    }
    
}
