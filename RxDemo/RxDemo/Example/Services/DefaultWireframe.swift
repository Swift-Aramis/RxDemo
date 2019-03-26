//
//  DefaultWireframe.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

protocol Wireframe {
    func open(url: URL)
}

class DefaultWireframe: Wireframe {

    static var rootViewController: UIViewController {
        get {
           return UIApplication.shared.keyWindow!.rootViewController!
        }
    }
    
    func open(url: URL) {
        UIApplication.shared.openURL(url)
    }
    
    static func presentAlert(_ message: String) {
        let alertView = UIAlertController(title: "RxDemo", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        rootViewController.present(alertView, animated: true, completion: nil)
    }
}
