//
//  Ext+UIButton.swift
//  SwiftPractice
//
//  Created by cleven on 15/10/22.
//  Copyright © 2015年 cleven. All rights reserved.
//

import UIKit

enum ClImagePosition {
    case left    //图片在左，文字在右，默认
    case right   //图片在右，文字在左
    case top     //图片在上，文字在下
    case bottom  //图片在下，文字在上
}

extension UIButton{


    // 遍历构造函数
    /// 创建button
    ///
    /// - parameter setImage:           默认状态图片
    /// - parameter setBackgroundImage: 背景图片
    /// - parameter target:             target
    /// - parameter action:             action
    ///
    /// - returns:
    convenience init(setImage:String,setBackgroundImage:String,target:Any?,action:Selector ){
//        let Btn = UIButton()
        self.init()
        
        self.setImage(UIImage(named:setImage), for: UIControlState.normal)
        self.setImage(UIImage(named:"\(setImage)_highlighted"), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(named:setBackgroundImage), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named:"\(setBackgroundImage)_highlighted"), for: UIControlState.highlighted)
        
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
    }
    
    
    
    /// 返回带文字的图片的按钮
    ///
    /// - parameter setHighlightImage: 背景图片
    /// - parameter title:             文字
    /// - parameter target:            target
    /// - parameter action:            action
    ///
    /// - returns: 
    convenience init(setHighlightImage:String?,title:String?,titleColor:UIColor? = UIColor.white,target:Any?,action:Selector ){
        //        let Btn = UIButton()
        self.init()

        if let img = setHighlightImage {
            self.setImage(UIImage(named:img), for: UIControlState.normal)

            self.setImage(UIImage(named:"\(img)_highlighted"), for: UIControlState.highlighted)
        }
        
        if let tit = title {
            self.setTitle(tit, for: UIControlState.normal)
            self.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            self.setTitleColor(titleColor, for: UIControlState.highlighted)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
        
    }

    convenience init(BackgroundImage:String?,title:String?,titleColor:UIColor, target:Any?,action:Selector ){
        
        self.init()

        self.setBackgroundImage(UIImage(named:BackgroundImage!), for: UIControlState.normal)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
        
    }
    
    /**
     *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
     *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
     *
     *  @param spacing 图片和文字的间隔
     */
     func cl_ButtonPostion(postion:ClImagePosition,spacing:CGFloat){
    
        let imageWith = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        let labelSize = (self.titleLabel?.text as NSString? )?.size(withAttributes: [NSAttributedStringKey.font:self.titleLabel?.font ?? 12])
        let imageOffsetX = (imageWith! + (labelSize?.width)!) / 2 - imageWith! / 2
        let imageOffsetY = imageHeight! / 2 + spacing / 2
        let labelOffsetX = (imageWith! + (labelSize?.width)! / 2) - (imageWith! + (labelSize?.width)!) / 2
        let labelOffsetY = (labelSize?.height)! / 2 + spacing / 2
        
        switch postion {
        case .left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2)
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2)
            break
        case .right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, (labelSize?.width)! + spacing/2, 0, -((labelSize?.width)! + spacing/2))
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight! + spacing/2), 0, imageHeight! + spacing/2)
            break
        case .top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetY - 5, -labelOffsetY, labelOffsetX)
            break
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX)
            break
            
        }
        
    }

}
