//
//  SettingViewController.swift
//  test2048View
//
//  Created by Carl Yi on 15/8/29.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import UIKit

// 下面有一处需要传值，所以必须继承这个class：UITextFieldDelegate
class SettingViewController:UIViewController, UITextFieldDelegate
{
    var txtNum:UITextField!
    var segDimension:UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupControls()
    }
    
    func setupControls()
    {
        txtNum = ViewFactory.createTextField("",action:Selector(""), sender:self)
        
        txtNum.frame = CGRect(x:80,y:100,width:200,height:30)
        txtNum.returnKeyType = UIReturnKeyType.Done
        
        self.view.addSubview(txtNum)
        
        let labelNum = ViewFactory.createLabel("阈值:")
        labelNum.frame = CGRect(x: 20, y: 100, width: 60, height: 30)
        self.view.addSubview(labelNum)
        //创建分段单选控件
        segDimension = ViewFactory.createSegment(["3x3", "4x4", "5x5"], action:"dimensionChanged:", sender:self)
        
        segDimension.frame = CGRect(x:80,y: 200,width: 200,height: 30)
        
        self.view.addSubview(segDimension)
        
        segDimension.selectedSegmentIndex = 1
        
        let labelDm = ViewFactory.createLabel("维度:")
        labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
        self.view.addSubview(labelDm)
    }
}
