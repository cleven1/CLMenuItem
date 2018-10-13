//
//  CLMenuView.swift
//  CLMenuView
//
//  Created by 赵永强 on 2017/10/19.
//  Copyright © 2017年 cleven. All rights reserved.
//

import UIKit

public enum menuItemType {
    case copy       // 复制
    case transmit   //转发
    case collect    //收藏
    case delete     //删除
    case revoke     //撤回
    case download   //下载
    case upload     //上传
    case reply      //回复
    case report      //举报
    case addone     //添加
    case cancel     //取消
    case link       //链接
    case pause      //暂停
    case resend     //重试
    case select     //选择
    case close      //关闭
    case translate  //翻译
    case edit
}


/// 点击代理回调
public protocol ClMenuItemViewDelegate:NSObjectProtocol {
    //回调每个item的index
    func menuItemAction(indexPath:IndexPath,itemIndex:Int)
}


public class CLMenuView: UIView {
    
    fileprivate var isShowMenuView:Bool = false
    fileprivate var preIndexPath:IndexPath = IndexPath(row: 10000, section: 0)
    fileprivate var isFinishedInit:Bool = false
    fileprivate let clBundlePath = Bundle.main.path(forResource: "CLResource", ofType: "bundle")
    
    //MARK:公共属性
    //代理回调
    weak public var delegate:ClMenuItemViewDelegate?
    // 闭包回调
    public var clickMenuitemIndex:((_ indexPath:IndexPath,_ itemIndex:Int)->())?
    
    //显示menuView
    public func showMenuItemView(indexPath:IndexPath){
        if indexPath.row != preIndexPath.row {
            isShowMenuView = true
        }else if indexPath.row == preIndexPath.row && isShowMenuView == false{
            isShowMenuView = true
        }else{
            isShowMenuView = false
        }
        if isShowMenuView {
            showMenuView()
        }else{
            hideMenuView()
        }
        preIndexPath = indexPath
    }
    
    /// 隐藏menuView
    public func hiddenMenuItemView(){
        if isShowMenuView == false {return}
        hideMenuView()
        isShowMenuView = false
    }
    
    fileprivate func showMenuView(){
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
    fileprivate func hideMenuView(){
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.0
        }) { (isComplete) in
            if self.superview == nil {return}
            self.removeFromSuperview()
        }
    }
    //MARK: 私有属性
    fileprivate var menuItems:[menuItemType]?
    fileprivate var itemCount:Int = 0
    
    fileprivate lazy var containerView:UIView = UIView()
    fileprivate lazy var backgroundImageView:UIImageView = {
        let backImageView = UIImageView()
        let bgImage = UIImage(named: "cl_menu_longpress_bg", in: Bundle(path: (clBundlePath ?? "") + "/imageSources"), compatibleWith: nil)
        let left:Int = Int((bgImage?.size.width)! * 0.5)
        let top:Int = Int((bgImage?.size.height)! * 0.5)
        backImageView.image = bgImage?.stretchableImage(withLeftCapWidth: left, topCapHeight: top)
        backImageView.isUserInteractionEnabled = true
        return backImageView
    }()
    fileprivate lazy var arrowImageView:UIImageView = UIImageView()
    
    
    //初始化方法
    public init(itemTypes:[menuItemType]) {
        super.init(frame: .zero)
        self.alpha = 0
        self.menuItems = itemTypes
        self.itemCount = itemTypes.count
        
        setUpUI()
        
    }
    
    //设置控件frame
    public func setTargetRect(targetRect:CGRect){
        setMenuViewFrame(targetRect:targetRect)
        if isFinishedInit {return}
        initData()
        isFinishedInit = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc public func clickItemButton(sender:UIButton){
        
        delegate?.menuItemAction(indexPath: preIndexPath, itemIndex: sender.tag)
        
        clickMenuitemIndex?(preIndexPath,sender.tag)
    }
}

public extension CLMenuView
{
    
    fileprivate func setUpUI(){
        addSubview(backgroundImageView)
        addSubview(arrowImageView)
    }
    
    fileprivate func initData(){
        backgroundImageView.addSubview(containerView)
        containerView.frame = CGRect(x: 0, y: 8, width: backgroundImageView.bounds.size.width, height: backgroundImageView.bounds.size.height)
        
        guard let items = self.menuItems else {
            return
        }
        
        for (index,element) in items.enumerated() {
            
            let menuBtn = UIButton()
            menuBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            menuBtn.setTitleColor(UIColor.cl_colorWithHex(hex: 0xd4d4d4), for: UIControlState.normal)
            menuBtn.addTarget(self, action: #selector(clickItemButton(sender:)), for: UIControlEvents.touchUpInside)
            menuBtn.tag = index
            
            var title:String
            var imageName:String
            switch element {
            case .transmit:
                title = "转发"
                imageName = "cl_menu_share"
                break;
            case .collect:
                title = "收藏"
                imageName = "cl_menu_favorite"
                break;
            case .delete:
                title = "删除"
                imageName = "cl_menu_delete"
                break;
            case .revoke:
                title = "撤回"
                imageName = "cl_menu_revoke"
                break;
            case .download:
                title = "下载"
                imageName = "cl_menu_download"
                break;
            case .copy:
                title = "复制"
                imageName = "cl_menu_copy"
                break;
            case .reply:
                title = "回复"
                imageName = "cl_menu_reply"
                break;
            case .report:
                title = "举报"
                imageName = "cl_menu_report"
                break;
            case .addone:
                title = "添加"
                imageName = "cl_menu_addone"
                break;
            case .cancel:
                title = "取消"
                imageName = "cl_menu_cancel"
                break;
            case .link:
                title = "链接"
                imageName = "cl_menu_link"
                break;
            case .pause:
                title = "暂停"
                imageName = "cl_menu_pause"
                break;
            case .resend:
                title = "重试"
                imageName = "cl_menu_resend"
                break;
            case .select:
                title = "选择"
                imageName = "cl_menu_select"
                break;
            case .upload:
                title = "上传"
                imageName = "cl_menu_upload"
                break;
            case .close:
                title = "关闭"
                imageName = "cl_menu_close"
                break;
            case .translate:
                title = "翻译"
                imageName = "cl_menu_translate"
                break;
            case .edit:
                title = "编辑"
                imageName = "cl_menu_edit"
            }
            menuBtn.setTitle(title, for: UIControlState.normal)
           menuBtn.setImage(UIImage(named: imageName, in: Bundle(path: (clBundlePath ?? "") + "/imageSources"), compatibleWith: nil), for: .normal)
            menuBtn.cl_ButtonPostion(postion: .top, spacing: 3)
            
            containerView.addSubview(menuBtn)
            menuBtn.frame = CGRect(x: CGFloat(index) * (containerView.bounds.size.width / CGFloat(itemCount)), y: 0, width: containerView.bounds.size.width / CGFloat(itemCount), height: containerView.bounds.size.height)
        }
        
        
    }
    
    fileprivate func setMenuViewFrame(targetRect:CGRect){
        
        let screenW = UIScreen.main.bounds.size.width
        let screenH = UIScreen.main.bounds.size.height
        let itemW:CGFloat = 50.0
        let targetCenterX = targetRect.origin.x + targetRect.size.width / 2
        let menuW:CGFloat = CGFloat(itemCount) * itemW
        let menuH:CGFloat = 58.0
        var menuX = targetCenterX - menuW / 2 > 0 ? targetCenterX - menuW / 2 : 0
        menuX = menuX + menuW > screenW ? screenW - menuW : menuX
        var menuY:CGFloat = targetRect.origin.y - menuH
        // 避免 MenuController 过于靠上
        menuY = menuY < 20 ? targetRect.origin.y + targetRect.size.height : menuY
        // 适配特别长的文本，直接显示在屏幕中间
        menuY = menuY > screenH - menuH - 30 ? screenH / 2 : menuY
        
        let frame = CGRect(x: menuX, y: menuY, width: menuW, height: menuH)
        
        self.frame = frame
        
        let arrowH:CGFloat = 8.0
        let arrowW:CGFloat = 12.0
        let arrowX:CGFloat = targetRect.origin.x - frame.origin.x + 0.5 * targetRect.size.width - arrowW / 2
        if frame.origin.y > targetRect.origin.y {
            //箭头向上
            backgroundImageView.frame = CGRect(x: 0, y: arrowH, width: menuW, height: menuH - arrowH)
            arrowImageView.image = UIImage(named: "cl_menu_longpress_up_arrow", in: Bundle(path: (clBundlePath ?? "") + "/imageSources"), compatibleWith: nil)
            arrowImageView.frame = CGRect(x: arrowX, y: 0, width: arrowW, height: arrowH)
        }else{
            //箭头向下
            backgroundImageView.frame = CGRect(x: 0, y: 0, width: menuW, height: menuH - arrowH)
            arrowImageView.image = UIImage(named: "cl_menu_longpress_down_arrow", in: Bundle(path: (clBundlePath ?? "") + "/imageSources"), compatibleWith: nil)
            arrowImageView.frame = CGRect(x: arrowX, y: menuH - arrowH, width: arrowW, height: arrowH)
        }
        
    }
    
}

public extension UIColor {
    
    fileprivate class func cl_colorWithHex(hex:UInt32) ->UIColor {
        let r = (hex & 0xFF0000)>>16
        let g = (hex & 0x00FF00)>>8
        let b = (hex & 0x0000FF)
        
        return UIColor(red: CGFloat(Float(r)/255.0), green:CGFloat(Float(g)/255.0) , blue: CGFloat(Float(b)/255.0), alpha: 1.0)
    }
}

public extension UIButton{
   fileprivate enum ClImagePosition {
        case left    //图片在左，文字在右，默认
        case right   //图片在右，文字在左
        case top     //图片在上，文字在下
        case bottom  //图片在下，文字在上
    }
   fileprivate func cl_ButtonPostion(postion:ClImagePosition,spacing:CGFloat){
        
        let imageWith = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        let labelSize = titleLabel?.attributedText?.size()
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

