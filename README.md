# SJIniteScrollView

This is an infinite photos play framework [前往Swift版](https://github.com/king129/SJIniteScrollViewSwift.git)

#### 效果演示

![](SJIniteScrollView.gif)

![](SJIniteScrollView2.gif)

- 支持本地图片和`网络图片(通过block或者代理加载)`
- 通过`block`或者`代理`监听图片点击

### 基本用法

``` objective-c
    // 创建并设置尺寸
    SJIniteScrollView *initeScrollView = [[SJIniteScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    // 加载本地数据
    initeScrollView.images = @[[UIImage imageNamed:@"image0"],
                               [UIImage imageNamed:@"image1"],
                               [UIImage imageNamed:@"image2"],
                               [UIImage imageNamed:@"image3"],
                               [UIImage imageNamed:@"image4"],
                               [UIImage imageNamed:@"image5"]
                               ];
    // 设置滚动方向
    initeScrollView.direction = SJIniteScrollViewDirectionVertical;
    // 监听图片点击 可以通过Block或者代理
    [initeScrollView didSelectItemIndex:^(NSInteger index) {
        NSLog(@"点击第%zd个", index);
    }];
    // 设置pageControl 的一些属性 默认有图片
    initeScrollView.pageImage = [UIImage imageNamed:@"Star1"];
    initeScrollView.currentPageImage = [UIImage imageNamed:@"Star2"];
    // 添加到view中
    [self.view addSubview:initeScrollView];
```

###### 默认pageControl控件在右下角,如需更改位置请子类化,在子类中调整布局

``` objective-c
- (void)layoutSubviews {
    [super layoutSubviews];
    self.pageControl.frame = CGRectMake(0, 150, 150, 30);
}
```

### 安装

- CocoaPods集成

``` objective-c
pod 'SJIniteScrollView'
```

- 手动集成

``` 
将`SJIniteScrollView`文件夹拖入工程即可
```

