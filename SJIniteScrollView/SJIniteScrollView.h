//
//  SJIniteScrollView.h
//  SJIniteScrollViewExample
//
//  Created by king on 16/2/21.
//  Copyright © 2016年 king. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SJIniteScrollViewDirection) {
    
    SJIniteScrollViewDirectionHorizontal = 0, // 水平滚动
    SJIniteScrollViewDirectionVertical        // 垂直滚动
};
@class SJIniteScrollView;

@protocol SJIniteScrollViewDelegate <NSObject>
@optional
/**
 *  监听图片点击
 *
 *  @param scrollView 自身
 *  @param index      点击时对应的索引
 */
- (void)initeScrollView:(SJIniteScrollView *)scrollView didSelectItemIndex:(NSInteger)index;
/**
 *  加载网络图片
 *
 *  @param scrollView 自身
 *  @param imageView  要加载的imageView
 *  @param url        对应的url
 */
- (void)initeScrollView:(SJIniteScrollView *)scrollView loadImage:(UIImageView *)imageView imageUrl:(NSURL *)url;

@end
@interface SJIniteScrollView : UIView
/** 加载本地图片 */
@property (nonatomic, strong) NSArray *images;
/** 加载网络图片 */
@property (nonatomic, strong) NSArray *imagesUrl;
/** 方向 */
@property (nonatomic, assign) SJIniteScrollViewDirection direction;
@property (nonatomic, strong) UIImage *pageImage;
@property (nonatomic, strong) UIImage *currentPageImage;
@property (nonatomic, weak,readonly) UIPageControl *pageControl;
@property (nonatomic, weak) id<SJIniteScrollViewDelegate> delegate;

/**
 *  监听图片点击
 */
- (void)didSelectItemIndex:(void(^)(NSInteger index))SelectBlock;
/**
 *  加载网络图片
 */
- (void)loadImage:(void(^)(UIImageView *imageView, NSURL *url))Block;
@end

/*************************** UIView扩展 ************************************/
@interface UIView(SJ)
@property (nonatomic, assign) CGFloat sj_width;
@property (nonatomic, assign) CGFloat sj_height;
@property (nonatomic, assign) CGFloat sj_x;
@property (nonatomic, assign) CGFloat sj_y;
@property (nonatomic, assign) CGFloat sj_centerX;
@property (nonatomic, assign) CGFloat sj_centerY;
@property (nonatomic, assign) CGFloat sj_right;
@property (nonatomic, assign) CGFloat sj_bottom;
@end