//
//  MainViewController.swift
//  test2048View
//
//  Created by Carl Yi on 15/8/29.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import UIKit

enum Animation2048Type
{
    case None   //无动画
    case New    //新出现动画
    case Merge  //合并动画
}

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
    
    //保存界面上的数字Label数据
    var tiles: Dictionary<NSIndexPath, TileView>!
    //保存实际数字值的一个字典
    var tileVals: Dictionary<NSIndexPath, Int>!
    
    init()
    {
        self.backgrounds = Array<UIView>()
        super.init(nibName:nil, bundle:nil)
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        
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
        setupSwipeGuestures()
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
    
    func setupSwipeGuestures()
    {
        //监控向上的方向，相应的处理方法 swipeUp
        let upSwipe = UISwipeGestureRecognizer(target:self, action:Selector("swipeUp"))
        
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        //监控向下的方向，相应的处理方法 swipeDown
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        //监控向左的方向，相应的处理方法 swipeLeft
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        //监控向右的方向，相应的处理方法 swipeRight
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    func _showTip(direction:String)
    {
        let alertController = UIAlertController(title: "提示", message: "你刚刚向\(direction)滑动了！", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    func printTiles(tiles:Array<Int>)
    {
        var count = tiles.count
        for var i=0; i<count; i++
        {
            if (i+1) % Int(dimension) == 0
            {
                println(tiles[i])
            }
            else
            {
                print("\(tiles[i])\t")
            }
        }
        
        println("")
        
    }
    func swipeUp()
    {
        println("swipeUp")
        
        println(self.dimension * self.dimension)
        println()
        gmodel.reflowUp()
        gmodel.mergeUp()
        gmodel.reflowUp()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        //  resetUI()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
        
    }

    func swipeDown()
    {
        println("swipeDown")
        gmodel.reflowDown()
        gmodel.mergeDown()
        gmodel.reflowDown()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        //  resetUI()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }
    
    func swipeLeft()
    {
        println("swipeLeft")
        gmodel.reflowLeft()
        gmodel.mergeLeft()
        gmodel.reflowLeft()
        
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        //  resetUI()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }
    
    func swipeRight()
    {
        println("swipeRight")
        gmodel.reflowRight()
        gmodel.mergeRight()
        gmodel.reflowRight()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        
        //   resetUI()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }

    func insertTile(pos:(Int, Int), value:Int, atype:Animation2048Type)
    {
        let (row, col) = pos;
        
        let x = 50 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x,y), width:width, value:value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        //保存数字块视图和数字块上数字的键，是 NSIndexPath 类型
        var index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        //设置动画的初始状态
        //如果不需要动画
        if(atype == Animation2048Type.None)
        {
            return
        }
        else if(atype == Animation2048Type.New) //新生成数字
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1,0.1))
        }
        else if(atype == Animation2048Type.Merge) //合并中的数字
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8,0.8))
        }
        UIView.animateWithDuration(0.1, delay:0.01, options:UIViewAnimationOptions.TransitionNone, animations:
            {
                ()-> Void in
                tile.layer.setAffineTransform(CGAffineTransformMakeScale(1,1))
            },
            completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.08, animations:{
                    ()-> Void in
                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
                })
                
        })
    }
//    func insertTile(pos:(Int, Int), value:Int)
//    {
//        let (row, col) = pos;
//
//        let x = 50 + CGFloat(col) * (width + padding)
//        let y = 150 + CGFloat(row) * (width + padding)
//        
//        let tile = TileView(pos: CGPointMake(x,y), width:width, value:value)
//        self.view.addSubview(tile)
//        self.view.bringSubviewToFront(tile)
//        
//        //alpha属性为0.0时视图完全透明，为1.0时完全不透明
////        tile.alpha = 0.0
//        tile.alpha = 1
//        UIView.animateWithDuration(2, delay: 1, options: UIViewAnimationOptions.TransitionNone, animations:
//            {
//                () -> Void in
//            },
//            completion: {
//                (finished:Bool) -> Void in
//                UIView.animateWithDuration(1, animations: {
//                    () -> Void in
//                    tile.alpha = 1
//                })
//            })
//        
///*
//        //先将数字块大小置为原始尺寸的 1/10
//        tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1,0.1))
//        
//        //设置动画效果，动画时间长度 1 秒。
//        UIView.animateWithDuration(1, delay:0.01, options:UIViewAnimationOptions.TransitionNone, animations:
//            {
//                ()-> Void in
//                //在动画中，数字块有一个角度的旋转。
//                tile.layer.setAffineTransform(CGAffineTransformMakeRotation(90))
//            },
//            completion:{
//                (finished:Bool) -> Void in
//                UIView.animateWithDuration(1, animations:{
//                    ()-> Void in
//                    //完成动画时，数字块复原
//                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
//                })
//                
//        })
//*/
//    }
    
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
        for i in 0..<5
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
            insertTile((row, col), value: seed, atype:Animation2048Type.New)
        }
    }
    
    //根据数据模型重新
    func initUI()
    {
        
        var index:Int
        var key:NSIndexPath
        var tile:TileView
        var tileVal:Int
        
        for i in 0..<dimension
        {
            for j in 0..<dimension
            {
                index = i*self.dimension + j
                key = NSIndexPath(forRow:i, inSection:j)
                //原来界面没有值，模型数据中有值
                if((gmodel.tiles[index]>0) && tileVals.indexForKey(key)==nil)
                {
                    insertTile((i,j),value:gmodel.tiles[index], atype:Animation2048Type.Merge)
                }
                //原来界面中有值，现在模型中没有值 了
                if((gmodel.tiles[index] == 0) && (tileVals.indexForKey(key) != nil))
                {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                }
                //原来值，但是现在还有值
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) != nil))
                {
                    tileVal = tileVals[key]!
                    //如果不相等，换掉值就可以了
                    if(tileVal != gmodel.tiles[index])
                    {
                        tile = tiles[key]!
                        tile.value = gmodel.tiles[index]
                        tileVals[key] = gmodel.tiles[index]
                    }
                    //如果相等，当然什么也不用做了
                }
                
            }
        }
    }
    
    
}