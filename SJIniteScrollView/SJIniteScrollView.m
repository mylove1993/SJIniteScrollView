//
//  SJIniteScrollView.m
//  SJIniteScrollViewExample
//
//  Created by king on 16/2/21.
//  Copyright © 2016年 king. All rights reserved.
//

#import "SJIniteScrollView.h"

@interface SJIniteScrollView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) void(^MyBlock)(NSInteger);
@property (nonatomic, assign) void(^loadBlock)(UIImageView *, NSURL *);

@end

@implementation SJIniteScrollView
#pragma mark ------------------------------------
#pragma mark  初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        // 1.添加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 初始化一些设置
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.添加3个imageView
        for (NSInteger i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)]];
            [scrollView addSubview:imageView];
        }
        
        // 3.添加pageController
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl setValue:[UIImage imageNamed:@"SJIniteScrollView.bundle/otherPage"] forKeyPath:@"_pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"SJIniteScrollView.bundle/currentPage"] forKeyPath:@"_currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 开启定时器
        [self startTime];
    }
    return self;
}

#pragma mark ------------------------------------
#pragma mark  布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat scrollViewW = self.sj_width;
    CGFloat scrollViewH = self.sj_height;
    // scrollView
    self.scrollView.frame = self.bounds;
    if (_direction == SJIniteScrollViewDirectionHorizontal) {
        self.scrollView.contentSize = CGSizeMake(3 * scrollViewW, scrollViewH);
    } else {
        self.scrollView.contentSize = CGSizeMake(scrollViewW, 3 * scrollViewH);
    }
    // imageView
    for (NSInteger i = 0; i < 3; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        if (_direction == SJIniteScrollViewDirectionHorizontal) {
            imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        } else {
            imageView.frame = CGRectMake(0, i * scrollViewH, scrollViewW, scrollViewH);
        }
    }
    // pageControl
    CGFloat pageControlW = 150;
    CGFloat pageControlH = 30;
    self.pageControl.frame = CGRectMake(scrollViewW - pageControlW, scrollViewH - pageControlH, pageControlW, pageControlH);
    // 更新内容
    [self updateCoenten];
}
#pragma mark ------------------------------------
#pragma mark  重写属性setter
- (void)setImages:(NSArray *)images {
    _images = images;
    self.pageControl.numberOfPages = images.count;
}
- (void)setImagesUrl:(NSArray *)imagesUrl {
    _imagesUrl = imagesUrl;
    self.pageControl.numberOfPages = imagesUrl.count;
}
- (void)setPageImage:(UIImage *)pageImage {
    _pageImage = pageImage;
   [self.pageControl setValue:pageImage forKeyPath:@"_pageImage"];
}
- (void)setCurrentPageImage:(UIImage *)currentPageImage {
    
    _currentPageImage = currentPageImage;
    [self.pageControl setValue:currentPageImage forKeyPath:@"_currentPageImage"];
}
#pragma mark ------------------------------------
#pragma mark  更新内容
/**
 *  更新所有UIImageView的内容，并且重置scrollView.contentOffset.x/y == 1倍宽度/高度
 */
- (void)updateCoenten {
   
    // 取出当前页码
    NSInteger page = self.pageControl.currentPage;
    // 更新imageView内容
    for (NSInteger i = 0; i < 3; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        // 图片索引
        NSInteger index = 0;
        if (i == 0) { // 左边的ImageView
            index = page - 1;
        } else if (i == 1) { // 中间的ImageView
            index = page;
        } else { // 右边的ImageView
            index = page + 1;
        }
        // 处理特殊情况
        if (index == -1) {
            if (self.images) {
                index = self.images.count - 1;
            } else if (self.imagesUrl) {
                index = self.imagesUrl.count - 1;
            }
        } else if (index == self.images.count || index == self.imagesUrl.count) {
            index = 0;
        }
        if (self.images) {
            imageView.image = self.images[index];
        } else if (self.imagesUrl) {
            NSURL *url = [NSURL URLWithString:self.imagesUrl[index]];
            if ([self.delegate respondsToSelector:@selector(initeScrollView:loadImage:imageUrl:)]) {
                [self.delegate initeScrollView:self loadImage:imageView imageUrl:url];
            }
            if (self.loadBlock) {
                self.loadBlock(imageView, url);
            }
        }
        imageView.tag = index;
    }
    // 重置scrollView.contentOffset.x / y == 1倍宽度/高度
    if (_direction == SJIniteScrollViewDirectionHorizontal) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.sj_width, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.sj_height);
    }
}
#pragma mark ------------------------------------
#pragma mark  图片点击处理
- (void)imageViewClick:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(initeScrollView:didSelectItemIndex:)]) {
        [self.delegate initeScrollView:self didSelectItemIndex:tap.view.tag];
    }
    
    if (self.MyBlock) {
        self.MyBlock(tap.view.tag);
    }
}
- (void)didSelectItemIndex:(void (^)(NSInteger))SelectBlock {
    
    self.MyBlock = SelectBlock;
}
- (void)loadImage:(void (^)(UIImageView *, NSURL *))Block {
    self.loadBlock = Block;
}
#pragma mark ------------------------------------
#pragma mark  定时器处理
- (void)startTime {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextPage {
    if (_direction == SJIniteScrollViewDirectionHorizontal) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.sj_width, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + self.scrollView.sj_height) animated:YES];
    }
}
#pragma mark ------------------------------------
#pragma mark  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIImageView *tmpImageView  = nil;
    CGFloat minDelta = MAXFLOAT;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat delta = 0;
        if (_direction == SJIniteScrollViewDirectionHorizontal) {
            delta = ABS(self.scrollView.contentOffset.x - imageView.sj_x);
        } else {
            delta = ABS(self.scrollView.contentOffset.y - imageView.sj_y);
        }
        
        if (delta < minDelta) {
            minDelta = delta;
            tmpImageView = imageView;
        }
        
        self.pageControl.currentPage = tmpImageView.tag;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateCoenten];
    [self startTime];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateCoenten];
}
@end


/*************************** UIView扩展 ************************************/
@implementation UIView (SJ)
- (CGFloat)sj_width{
    return self.frame.size.width;
}
- (void)setSj_width:(CGFloat)sj_width {
    CGRect frame = self.frame;
    frame.size.width = sj_width;
    self.frame = frame;
}


- (CGFloat)sj_height{
    return self.frame.size.height;
}

- (void)setSj_height:(CGFloat)sj_height{
    CGRect frame = self.frame;
    frame.size.height = sj_height;
    self.frame = frame;
}

- (CGFloat)sj_x{
    return self.frame.origin.x;
}
- (void)setSj_x:(CGFloat)sj_x{
    CGRect frame = self.frame;
    frame.origin.x = sj_x;
    self.frame = frame;
}

- (CGFloat)sj_y{
    return self.frame.origin.y;
}
- (void)setSj_y:(CGFloat)sj_y{
    CGRect frame = self.frame;
    frame.origin.y = sj_y;
    self.frame = frame;
}

- (void)setSj_centerY:(CGFloat)sj_centerY {
    CGPoint center = self.center;
    center.y = sj_centerY;
    self.center = center;
}
- (CGFloat)sj_centerY
{
    return self.center.y;
}
- (void)setSj_centerX:(CGFloat)sj_centerX {
    CGPoint center = self.center;
    center.x = sj_centerX;
    self.center = center;
}

- (CGFloat)sj_centerX
{
    return self.center.x;
}

- (CGFloat)sj_right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)sj_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setSj_right:(CGFloat)sj_right {
    self.sj_x = sj_right - self.sj_width;
}

- (void)setSj_bottom:(CGFloat)sj_bottom {
    self.sj_y = sj_bottom - self.sj_height;
}
@end
