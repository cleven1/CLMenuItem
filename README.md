# CLMenuView
[](/Users/zhaoyongqiang/Desktop/menuItemGIF.gif)

#### 快速创建menuItem控件,使用简单,可扩展,默认提供了很多种类型,使用时只需要把需要的枚举类型加到初始化数组即可

###初始化方法
```
lazy var menuItem:CLMenuView = {
let menuItem = CLMenuView(itemTypes: [.copy,.collect,.reply,.report,.resend,.translate])

menuItem.delegate = self

return menuItem
}()
```

###设置menuView的frame
```
let keyWindow = UIApplication.shared.keyWindow

keyWindow?.addSubview(self.menuItem)

把需要添加view的frame 转化到keyWindow上
let rect = cell?.contentView.convert((cell?.contentView.frame)!, to: keyWindow)

menuItem.setTargetRect(targetRect: rect!)
```


### 点击item回调函数  此函数会把每个item的index回调出来
```
func menuItemAction(item: NSInteger) {

print("=====Index = \(item)")
}
```

###显示于隐藏函数
```
显示
menuItem.showMenuView()

隐藏
menuItem.hideMenuView()

```
