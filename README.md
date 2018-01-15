# CLMenuView

### 如果对您有帮助,请点个星星,感谢

[](file:/Users/cleven/Desktop/CLMenuItem/menuItem.gif)

###支持cocoaPods

```
pod 'CLMenuItem'
```

#### 快速创建menuItem控件,使用简单,可扩展,默认提供了很多种类型,使用时只需要把需要的枚举类型加到初始化数组即可

### 初始化方法

###### 新增闭包回调方式,支持代理和闭包回调
```
lazy var menuItem:CLMenuView = {
let menuItem = CLMenuView(itemTypes: [.copy,.collect,.reply,.report,.resend,.translate])

menuItem.delegate = self

return menuItem
}()
```

### 设置menuView的frame
```
guard let keyWindow = UIApplication.shared.delegate?.window else {return}

if menuItem.alpha == 0 {
keyWindow?.addSubview(self.menuItem)
}

把需要添加view的frame 转化到keyWindow上
let rect = cell?.contentView.convert((cell?.contentView.frame)!, to: keyWindow)

menuItem.setTargetRect(targetRect: rect!)

menuItem.showMenuItemView(indexPath: indexPath)
```


### 点击item回调函数  此函数会把每个item的index回调出来
```
func menuItemAction(item: NSInteger) {

print("=====Index = \(item)")
}
```

### 添加闭包回调方式
```
clickMenuitemIndex:((_ indexPath:IndexPath,_ itemIndex:Int)->())
```


### 显示于隐藏函数
```
显示
menuItem.showMenuItemView(indexPath:IndexPath)

隐藏
menuItem.hiddenMenuItemView()

```
