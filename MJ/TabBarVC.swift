//
//  TabBarVC.swift
//  MJ
//
//  Created by Nagayama Ryo on 2017/10/17.
//  Copyright © 2017年 Nagayama Ryo. All rights reserved.
//

import Foundation
import  UIKit

class TabBarVC: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewControllers = [UIViewController]()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let scoreTableVC = storyboard.instantiateViewController(withIdentifier: "scoreTableVC")
        	scoreTableVC.tabBarItem = UITabBarItem(title: "点数状況", image: UIImage(named: "ScoreTable"), tag: 0)
        
        let scoreSheetVC = storyboard.instantiateViewController(withIdentifier: "scoreSheetVC")
        	scoreSheetVC.tabBarItem = UITabBarItem(title: "点数計算", image: UIImage(named: "ScoreSheet"), tag: 1)
        
//        let testVC = storyboard.instantiateViewController(withIdentifier: "testVC")
//        testVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
//        testVC.title = "テスト"
        
        viewControllers.append(scoreTableVC)
        viewControllers.append(scoreSheetVC)
//        viewControllers.append(testVC)
        
        self.setViewControllers(viewControllers, animated: true)
		self.selectedIndex = 0
    }
    
    
}
