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
    //游戏方格维度
    var dimension:Int = 4
    //游戏过关最大值
    var maxnumber:Int = 2048 {
        didSet{
            gmodel.maxnumber = maxnumber
        }
    }
    
    //数字格子的宽度
    var width:CGFloat = 50
    //格子与格子的间距
    var padding:CGFloat = 6
    
    //保存背景图数据
    var backgrounds:Array<UIView>!
    
    var gmodel:GameModel!
    //var gmodel:GameModelBA
    //var gmodel:GameModelMatrix
    var score:ScoreView!
    
    var bestscore:ScoreView!
    
    init()
    {
        self.backgrounds = Array<UIView>()
        super.init(nibName:nil, bundle:nil)
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //改成主视图背景白色背景
        self.view.backgroundColor = UIColor.whiteColor()
        setupGameMap()
        setupScoreLabels()
        self.gmodel = GameModel(dimension: self.dimension,
            maxnumber:self.maxnumber, score:score, bestscore:bestscore)
        for i in 0..<2
        {
            genNumber()
        }
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
            println(i)
            y = 150
            for j in 0..<dimension
            {
                //初始化视图
                var background = UIView(frame:CGRectMake(x, y, width, width))
                background.backgroundColor = UIColor.darkGrayColor()
                
                self.view.addSubview(background)
                //将视图保存起来，以备后用
                backgrounds.append(background)
                y += padding + width
            }
            x += padding+width
        }
    }
    
    func insertTile(pos:(Int, Int), value:Int)
    {
        let (row, col) = pos;
        
        let x = 50 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x,y), width:width, value:value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
    }
    
    func genNumber()
    {
        //用于确定随机数的概率
        let randv = Int(arc4random_uniform(10))
        println(randv)
        var seed:Int = 2
        //因为有 10%的机会，出现1，所以这里是 10%的机会给 4
        if(randv == 1)
        {
            seed = 4
        }
        //随机生成行号和列号
        var i = 0
        for i in 0..<4  //多随机生成一些数。填满4＊4的画面
        {
        let col =  Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        if(gmodel.isFull())
        {
            println("位置已经满了")
            return
        }
        if(gmodel.setPosition(row, col:col, value:seed)==false)
        {
            genNumber()
            return
        }
        //执行后续操作
        insertTile((row, col), value: seed)
        }
    }
}

/*
class MainViewController:UIViewController
{
    //game vector setting
    var dimension:Int = 4
    //max level 
    //var maxnumber:Int = 2048
    //游戏过关最大值
    var maxnumber:Int = 2048 {
        didSet{
            gmodel.maxnumber = maxnumber
        }
    }
    
    //width of the box
    var width:CGFloat = 50
    //space between the box
    var padding:CGFloat = 6
    
    //save the number of background picture
    var backgrounds:Array<UIView>!
    
    var gmodel:GameModel!
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
        self.gmodel = GameModel(dimension: self.dimension,
            maxnumber:self.maxnumber, score:score, bestscore:bestscore)
        for i in 0..<2
        {
            genNumber()
        }
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
    
    func insertTile(pos:(Int, Int), value:Int)
    {
        let (row, col) = pos;
        
        let x = 50 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x,y), width:width, value:value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
    }
    
    func genNumber()
    {
        //用于确定随机数的概率
        let randv = Int(arc4random_uniform(10))
        println(randv)
        var seed:Int = 2
        //因为有 10%的机会，出现1，所以这里是 10%的机会给 4
        if(randv == 1)
        {
            seed = 4
        }
        //随机生成行号和列号
        let col =  Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        if(gmodel.isFull())
        {
            println("位置已经满了")
            return
        }
        if(gmodel.setPosition(row, col:col, value:seed)==false)
        {
            genNumber()
            return
        }
        //执行后续操作
        insertTile((row, col), value: seed)
    }

}
*/