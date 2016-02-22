//
//  ViewController.m
//  SJIniteScrollViewExample
//
//  Created by king on 16/2/21.
//  Copyright © 2016年 king. All rights reserved.
//

#import "ViewController.h"
#import "SJIniteScrollView.h"
#import <UIImageView+WebCache.h>


@interface ViewController ()<SJIniteScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建并设置尺寸
    SJIniteScrollView *initeScrollView = [[SJIniteScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 250)];
    initeScrollView.delegate = self;
    // 设置本地数据
//    initeScrollView.images = @[[UIImage imageNamed:@"image0"],
//                               [UIImage imageNamed:@"image1"],
//                               [UIImage imageNamed:@"image2"],
//                               [UIImage imageNamed:@"image3"],
//                               [UIImage imageNamed:@"image4"],
//                               [UIImage imageNamed:@"image5"]
//                               ];
    // 设置滚动方向
    initeScrollView.direction = SJIniteScrollViewDirectionVertical;
    // 监听图片点击
    [initeScrollView didSelectItemIndex:^(NSInteger index) {
        NSLog(@"点击第%zd个", index);
    }];
    
    // 设置网络数据
    initeScrollView.imagesUrl = @[@"http://www.bz55.com/uploads/allimg/150204/139-150204144514.jpg",
                                  @"http://bizhi.33lc.com/uploadfile/2015/0617/20150617053223353.jpg",
                                  @"http://www.bz55.com/uploads/allimg/150204/139-150204144513.jpg",
                                  @"http://ww2.sinaimg.cn/large/971d1e3fjw1emoibaghmuj20px0fgmzh.jpg",
                                  @"http://img2.3lian.com/2014/f4/30/d/56.jpg"];

    [initeScrollView loadImage:^(UIImageView *imageView, NSURL *url) {
        
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"image0"]];
        
    }];
    
    // 设置pageControl 的一些属性
//    initeScrollView.pageImage = [UIImage imageNamed:@"Star1"];
//    initeScrollView.currentPageImage = [UIImage imageNamed:@"Star2"];
    // 添加到view中
    [self.view addSubview:initeScrollView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark ------------------------------------
#pragma mark  SJIniteScrollViewDelegate
- (void)initeScrollView:(SJIniteScrollView *)scrollView didSelectItemIndex:(NSInteger)index {
    NSLog(@"点击第%zd个", index);
}
- (void)initeScrollView:(SJIniteScrollView *)scrollView loadImage:(UIImageView *)imageView imageUrl:(NSURL *)url {
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"image0"]];
}
@end
