//
//  MyIniteScrollView.m
//  SJIniteScrollViewExample
//
//  Created by king on 16/2/22.
//  Copyright © 2016年 king. All rights reserved.
//

#import "MyIniteScrollView.h"

@implementation MyIniteScrollView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageControl.frame = CGRectMake(0, 150, 150, 30);
}

@end
