//
//  ViewController.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/24.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
//MARK: - 全局使用的头文件 @_exported import
@_exported import RxCocoa
@_exported import RxSwift

class ViewController: UIViewController {

    var tableView: UITableView!
    
    var dataSource = ["SimpleValidation",
                      "ImagePicker",
                      "TableView"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RxDemo"
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        let title = dataSource[indexPath.row]
        switch title {
        case "SimpleValidation":
            self.navigationController?.pushViewController(SimpleValidationVC(), animated: true)
        case "ImagePicker":
            self.navigationController?.pushViewController(ImagePickerVC(), animated: true)
        case "TableView":
            self.navigationController?.pushViewController(TableViewVC(), animated: true)
        default:
            print("--")
        }
    }
    
    // 可以去掉plain格式下最后一行的分割线
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

