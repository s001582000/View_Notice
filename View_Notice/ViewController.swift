//
//  ViewController.swift
//  View_Notice
//
//  Created by 梁雅軒 on 2017/4/2.
//  Copyright © 2017年 zoaks. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MyViewDelegate {
    @IBOutlet weak var btnChangeColor: UIButton!
    @IBOutlet weak var btnAddRemove: UIButton!
    @IBOutlet weak var btnChangeSize: UIButton!
    var testView:MyView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnOnClick(_ sender: UIButton) {
        if sender == btnAddRemove {
            if testView == nil {
                testView = MyView(frame: CGRect(origin: self.view.center, size: CGSize(width: 100, height: 100)))
                testView.backgroundColor = UIColor.blue
                testView.delegate = self
                testView.block = {(type) -> Void in
                    switch type {
                    case 0:
                        print("我從block通知被改變大小")
                    case 1:
                        print("我從block通知被改變顏色")
                    case 2:
                        print("我從block通知被移除")
                    default:
                        break
                    }
                }
                self.view.addSubview(testView)
            }else{
                testView.leave()
            }
        }else if sender == btnChangeSize{
            testView.changeFrame()
        }else if sender == btnChangeColor{
            testView.changeColor()
        }
    }
    
    func myViewLeave() {
        print("我從delegate通知被移除")
    }
    
    func myViewChangeFrame() {
        print("我從delegate通知被改變大小")
    }
    
    func myViewChangeColor() {
        print("我從delegate通知被改變顏色")
    }

}


protocol MyViewDelegate {
    func myViewChangeFrame()
    func myViewChangeColor()
    func myViewLeave()
}

class MyView: UIView {
    typealias Block = (_ type:Int)->Void
    var block:Block?
    var delegate:MyViewDelegate?
    
    func changeFrame()  {
        var rect = self.frame
        rect.size.width -= 5
        rect.size.height -= 5
        self.frame = rect
        delegate?.myViewChangeFrame()
        block?(0)
    }
    
    func changeColor() {
        self.backgroundColor = self.backgroundColor == UIColor.blue ? UIColor.black : UIColor.blue
        delegate?.myViewChangeColor()
        block?(1)
    }
    
    func leave() {
        delegate?.myViewLeave()
        block?(2)
        self.removeFromSuperview()
    }
}
