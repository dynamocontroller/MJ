//
//  TestVC.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/18.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation
import UIKit

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 意味ない、tabBarSystemItemを使用するとtabItemのtitleは変更できない
        self.title = "テスト"
    }
}
