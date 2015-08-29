//
//  ViewController.swift
//  test2048View
//
//  Created by Carl Yi on 15/7/19.
//  Copyright (c) 2015年 Carl Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
   @IBAction func startGame(sender : UIButton){
        let alertView = UIAlertView()
        alertView.title = "开始！"
        alertView.message = "游戏就要开始，你准备好了么？"
        alertView.addButtonWithTitle("Ready Go!")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex:Int)
    {
        self.presentViewController(MainTabViewController(), animated: true, completion: nil)
    }
*/
    
    @IBAction func startGame(sender:UIButton)
    {
        let alertController = UIAlertController(title: "开始！", message: "游戏就要开始，你准备好了吗？", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ready Go!", style: UIAlertActionStyle.Default, handler: {
            action in
            self.presentViewController(MainTabViewController(), animated:
                true, completion:nil)
            
        }))

        self.presentViewController(alertController, animated: true, completion: nil)
   }
/*
    @IBAction func startGame(sender:UIButton)
    {
        let alertController = UIAlertController(title: "开始！", message: "游戏就要开始，你准备好了吗？", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ready Go!", style: UIAlertActionStyle.Default, handler:{
            action in
            self.presentViewController(MainTabViewController(), animated:
                true, completion:nil)
            
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
*/

}
