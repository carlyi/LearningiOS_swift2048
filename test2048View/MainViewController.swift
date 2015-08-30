//
//  MainViewController.swift
//  test2048View
//
//  Created by Carl Yi on 15/8/29.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import UIKit

class MainViewController:UIViewController
{
    //game vector setting
    var dimension:Int = 4
    //max level 
    var maxnumber:Int = 2048
    
    //width of the box
    var width:CGFloat = 50
    //space between the box
    var padding:CGFloat = 6
    
    //save the number of background picture
    var backgrounds:Array<UIView>!
    
    var score:ScoreView!
    
    var bestscore:ScoreView!
    
    init()
    {
        self.backgrounds = Array<UIView>()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //set the MainView to white background
        self.view.backgroundColor = UIColor.whiteColor()
        setupGameMap()
        setupScoreLabels()
    }
    
    func setupScoreLabels()
    {
        score = ScoreView(stype: ScoreType.Common)
        score.frame.origin = CGPointMake(50, 80)
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = ScoreView(stype: ScoreType.Best)
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
    }
    
    func setupGameMap()
    {
        var x:CGFloat = 50
        var y:CGFloat = 150
        
        for i in 0..<dimension
        {
            print(i)
            y = 150
            for j in 0..<dimension
            {
                //init the View
                var background = UIView(frame: CGRectMake(x, y, width, width))
                background.backgroundColor = UIColor.darkGrayColor()
                
                self.view.addSubview(background)
                //save the View for later use
                backgrounds.append(background)
                y += padding + width
            }
            x += padding + width
        }
    }
}
