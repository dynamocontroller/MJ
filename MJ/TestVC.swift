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
    
    static func instantiate() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className)
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 意味ない、tabBarSystemItemを使用するとtabItemのtitleは変更できない
        self.title = "テスト"
    }
}
