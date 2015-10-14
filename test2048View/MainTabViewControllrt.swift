//
//  MainTabViewControllrt.swift
//  test2048View
//
//  Created by Carl Yi on 15/8/29.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import UIKit


class MainTabViewController:UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //一共包含了两个视图
        var viewMain = MainViewController()
        viewMain.title = "2048"
        
        var viewSetting = SettingViewController()
        viewSetting.title = "设置"
        //分别声明两个视图控制器
        var main = UINavigationController(rootViewController:viewMain)
        var setting = UINavigationController(rootViewController:viewSetting)
        
        self.viewControllers = [
            main,setting
        ]
        //默认选中的是游戏主界面视图
        self.selectedIndex = 0
    }
    
}
