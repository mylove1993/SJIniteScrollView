//
//  SJIniteScrollView.h
//  SJIniteScrollViewExample
//
//  Created by king on 16/2/21.
//  Copyright © 2016年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelectBlock)(NSInteger index);

typedef NS_ENUM(NSInteger, SJIniteScrollViewDirection) {
    
    SJIniteScrollViewDirectionHorizontal = 0, // 水平滚动
    SJIniteScrollViewDirectionVertical        // 垂直滚动
};

@interface SJIniteScrollView : UIView
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imagesUrl;
@property (nonatomic, assign) SJIniteScrollViewDirection direction;
@property (nonatomic, strong) UIImage *pageImage;
@property (nonatomic, strong) UIImage *currentPageImage;
@property (nonatomic, weak,readonly) UIPageControl *pageControl;

- (void)didSelectItemIndex:(didSelectBlock)SelectBlock;
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