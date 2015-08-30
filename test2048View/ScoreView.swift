//
//  ScoreView.swift
//  test2048View
//
//  Created by Carl Yi on 15/8/30.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import UIKit
enum ScoreType{
    case Common
    case Best
}

protocol ScoreViewProtocol{
    func changeScore(value s : Int)
}

class ScoreView: UIView, ScoreViewProtocol
{
    var label:UILabel!
    
    var defaultFrame = CGRectMake(0, 0, 100, 30)
    var stype:String!
    var score: Int = 0 {
        didSet{
            //the label is changed as the scores change
            label.text = "\(stype):\(score)"
        }
    }
    
    init(stype: ScoreType)
    {
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame: defaultFrame)
        
        self.stype = (stype == ScoreType.Common ? "分数":"最高分")
        
        backgroundColor = UIColor.orangeColor()
        label.font = UIFont(name: "微软雅黑", size: 16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changeScore(value s: Int) {
        score = s
    }
}

