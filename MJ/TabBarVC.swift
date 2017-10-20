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
        
        
        
        let scoreBoardVC = ScoreBoardVC.instantiate()
		scoreBoardVC.tabBarItem = UITabBarItem(title: "点数状況", image: UIImage(named: "ScoreBoard"), tag: 0)
        
        let scoreCalculationVC = ScoreCalculationVC.instantiate()
        
        scoreCalculationVC.tabBarItem = UITabBarItem(title: "点数計算", image: UIImage(named: "ScoreCalculation"), tag: 1)
        
//        let testVC = TestVC.instantiate()
//        testVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
//        testVC.title = "テスト"
        
        viewControllers.append(scoreBoardVC)
        viewControllers.append(scoreCalculationVC)
//        viewControllers.append(testVC)
        
        self.setViewControllers(viewControllers, animated: true)
		self.selectedIndex = 0
    }
    
    
}
