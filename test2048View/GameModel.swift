//
//  GameModel.swift
//  test2048View
//
//  Created by Carl Yi on 15/8/31.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import Foundation
import  UIKit

class GameModel
{
    var dimension:Int = 0
    var tiles:Array<Int>
    var scoredelegate:ScoreViewProtocol!
    var bestscoredelegage:ScoreViewProtocol!
    var maxnumber:Int = 0
    
    init(dimension:Int, maxnumber:Int, score:ScoreViewProtocol, bestscore:ScoreViewProtocol)
    {
        self.maxnumber = maxnumber
        self.dimension = dimension
        self.scoredelegate = score
        self.bestscoredelegage = bestscore
        self.dimension = dimension
        self.maxnumber = maxnumber
        
        self.tiles = Array<Int>(count: self.dimension*self.dimension, repeatedValue: 0)
    }
    
    //find the empty space
    func emptyPositions() -> [Int]
    {
        var emptytiles = Array<Int>()
        
        for i in 0..<(dimension*dimension)
        {
            if(tiles[i] == 0)
            {
                emptytiles.append(i)
            }
        }
        
        return emptytiles
    }
    
    func isFull() -> Bool
    {
        if(emptyPositions().count == 0)
        {
            return true
        }
        
        return false
    }
    
    func printTiles()
    {
        println(tiles)
        println("输出数据模型数据")
        var count = tiles.count
        for var i = 0; i < count; i++
        {
            if(i+1) % Int(dimension) == 0
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
    
    //如果返回 false ,表示该位置 已经有值
    func setPosition(row:Int, col:Int, value:Int) -> Bool
    {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        //3行4列，即  row=2 , col=3  index=2*4+3 = 11
        //4行4列，即  3*4+3 = 15
        var index = self.dimension * row + col
        var val = tiles[index]
        if(val > 0)
        {
            println("该位置(\(row), \(col))已经有值了")
            return false
        }
        tiles[index] = value
        
        return true
    }

}