//
//  UIColor+Extension.swift
//  swift-test
//
//  Created by tusm on 2016/10/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UIColor {
  
    /**
     16进制颜色
    
     */
   public class func cl_colorWithHex(hex:UInt32) ->UIColor {
        let r = (hex & 0xFF0000)>>16
        let g = (hex & 0x00FF00)>>8
        let b = (hex & 0x0000FF)
        
        return cl_color(r: r, g: g, b: b)
    }
    
   private class func cl_color(r:UInt32,g:UInt32,b:UInt32)-> UIColor{
    
    return UIColor(red: CGFloat(Float(r)/255.0), green:CGFloat(Float(g)/255.0) , blue: CGFloat(Float(b)/255.0), alpha: 1.0)
    }
    
    /**
     RGB颜色
     
     */
    public class func cl_RGBColor(r:Float,g:Float,b:Float)->UIColor{

        return UIColor(red: CGFloat(Float(r)/255.0), green:CGFloat(Float(g)/255.0) , blue: CGFloat(Float(b)/255.0), alpha: 1.0)
    
    }
    
    /**
     随机色
     
     */
    public class func cl_randomColor()->UIColor{
        
        return cl_color(r: arc4random() % UInt32(256.0), g: arc4random() % UInt32(256.0), b: arc4random() % UInt32(256.0))
        
    }
    
}
