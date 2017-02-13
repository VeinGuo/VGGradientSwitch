# VGGradientSwitch
一个渐变效果的switch

# 设计图
- 设计作者 [Nick Buturishvili](https://dribbble.com/nick_buturishvili)
![images](https://d13yacurqjgara.cloudfront.net/users/408943/screenshots/2272690/switch.gif)

# 效果图
- gif效果图有点卡，可以下载demo后查看效果。
- 动画可能有些偏差，有任何问题可以issues给我。
![image](http://ojaltanzc.bkt.clouddn.com/switch_demo_1.gif)

## 使用
```objct
	VGGradientSwitch *switchButton = [[VGGradientSwitch alloc] init];
    [switchButton setOn:NO animated:YES];
    switchButton.action = ^(BOOL isOn){
        NSLog(@"%@",isOn?@"打开":@"关闭");
    };
```
- 也可以直接设置`storyboard`，现在只支持一个On属性初始化。
![image](http://ojaltanzc.bkt.clouddn.com/QQ20170213-160334.png)
- 暂时不支持设置背景颜色、边框、 ☑️和✖️颜色，将在后续更新。

