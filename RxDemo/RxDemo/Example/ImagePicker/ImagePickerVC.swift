//
//  ImagePickerVC.swift
//  RxDemo
//
//  Created by 提运佳 on 2018/12/27.
//  Copyright © 2018 Swift_Aramis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePickerVC: BaseController {

    @IBOutlet weak var selectedImgV: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var cropBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
//        cameraBtn.rx.tap.flatMapLatest { [weak self] _ in
//            return UIImagePickerController.rx.createWithParent(self) { picker in
//                    picker.sourceType = .camera
//                    picker.allowsEditing = false
//                }
//                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
//                .tale(1)
//        }
        
    }


}
