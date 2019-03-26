//
//  tableViewVC.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit

class TableViewVC: BaseController, UITableViewDelegate {

    @IBOutlet weak var tableV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = Observable.just(
            (0..<20).map({
                "\($0)"
            })
        )
        //注册cell
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        //配置cell
        items
            .bind(to: tableV.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = UITableViewCell.AccessoryType.detailButton
            }
            .disposed(by: disposeBag)
        
        //数据源选中
        tableV.rx.modelSelected(String.self).subscribe(onNext: { (value) in
             DefaultWireframe.presentAlert("Tapped `\(value)`")
        }).disposed(by: disposeBag)
        
        //cell点击
        tableV.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.tableV.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
        
        //cell详细按钮点击
        tableV.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
        
    }


}
