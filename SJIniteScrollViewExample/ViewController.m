//
//  ViewController.m
//  SJIniteScrollViewExample
//
//  Created by king on 16/2/21.
//  Copyright © 2016年 king. All rights reserved.
//

#import "ViewController.h"
#import "SJIniteScrollView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建并设置尺寸
    SJIniteScrollView *initeScrollView = [[SJIniteScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    // 设置数据
    initeScrollView.images = @[[UIImage imageNamed:@"image0"],
                               [UIImage imageNamed:@"image1"],
                               [UIImage imageNamed:@"image2"],
                               [UIImage imageNamed:@"image3"],
                               [UIImage imageNamed:@"image4"],
                               [UIImage imageNamed:@"image5"]
                               ];
    // 设置滚动方向
//    initeScrollView.direction = SJIniteScrollViewDirectionVertical;
    // 监听图片点击
    [initeScrollView didSelectItemIndex:^(NSInteger index) {
        NSLog(@"点击第%zd个", index);
    }];
    // 设置pageControl 的一些属性
//    initeScrollView.pageImage = [UIImage imageNamed:@"Star1"];
//    initeScrollView.currentPageImage = [UIImage imageNamed:@"Star2"];
    // 添加到view中
    [self.view addSubview:initeScrollView];
}


@end
