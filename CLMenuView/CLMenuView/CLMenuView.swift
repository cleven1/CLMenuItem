//
//  CLMenuView.swift
//  CLMenuView
//
//  Created by 赵永强 on 2017/10/19.
//  Copyright © 2017年 cleven. All rights reserved.
//

import UIKit

enum menuItemType {
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
}


/// 点击代理回调
protocol ClMenuItemViewDelegate:NSObjectProtocol {
    //回调每个item的index
    func menuItemAction(item:NSInteger)
}


class CLMenuView: UIView {
    
    //MARK:公共属性
    weak public var delegate:ClMenuItemViewDelegate?

    //显示menuView
    public func showMenuView(){
        
        UIView.animate(withDuration: 0.1) {
            
            self.alpha = 1.0
        }
    }
    //隐藏menuView
    public func hideMenuView(){
        
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.0
        }) { (isComplete) in
            if self.superview == nil {return}
            self.removeFromSuperview()
        }
    }

    //MARK: 私有属性
    fileprivate var menuItems:[menuItemType]?
    private var itemCount:Int = 0
    
    private lazy var containerView:UIView = UIView()
    private lazy var backgroundImageView:UIImageView = {
        let backImageView = UIImageView()
        let bgImage = UIImage(named: "cl_menu_longpress_bg")
        let left:Int = Int((bgImage?.size.width)! * 0.5)
        let top:Int = Int((bgImage?.size.height)! * 0.5)
        backImageView.image = bgImage?.stretchableImage(withLeftCapWidth: left, topCapHeight: top)
        backImageView.isUserInteractionEnabled = true
        return backImageView
    }()
    private lazy var arrowImageView:UIImageView = UIImageView()
    
    
    //初始化方法
    init(itemTypes:[menuItemType]) {
        super.init(frame: .zero)
        
        self.menuItems = itemTypes
        self.itemCount = itemTypes.count
        
        setUpUI()
        
    }
    
    //设置控件frame
    public func setTargetRect(targetRect:CGRect){
        
        setMenuViewFrame(targetRect:targetRect)
        
        initData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func clickItemButton(sender:UIButton){
        
        delegate?.menuItemAction(item: sender.tag)
    
    }
    
}

extension CLMenuView
{
    
    private func setUpUI(){
        addSubview(backgroundImageView)
        addSubview(arrowImageView)
        
    }
    
    private func initData(){
        
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
            }
            menuBtn.setTitle(title, for: UIControlState.normal)
            menuBtn.setImage(UIImage(named: imageName), for: UIControlState.normal)
            menuBtn.cl_ButtonPostion(postion: ClImagePosition.top, spacing: 3)
            
            containerView.addSubview(menuBtn)
            menuBtn.frame = CGRect(x: CGFloat(index) * (containerView.bounds.size.width / CGFloat(itemCount)), y: 0, width: containerView.bounds.size.width / CGFloat(itemCount), height: containerView.bounds.size.height)
        }
        
        
    }
    
    private func setMenuViewFrame(targetRect:CGRect){
        
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
            arrowImageView.image = UIImage(named: "cl_menu_longpress_up_arrow")
            arrowImageView.frame = CGRect(x: arrowX, y: 0, width: arrowW, height: arrowH)
        }else{
            //箭头向下
            backgroundImageView.frame = CGRect(x: 0, y: 0, width: menuW, height: menuH - arrowH)
            arrowImageView.image = UIImage(named: "cl_menu_longpress_down_arrow")
            arrowImageView.frame = CGRect(x: arrowX, y: menuH - arrowH, width: arrowW, height: arrowH)
        }
        
    }
}
