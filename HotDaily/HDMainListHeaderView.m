//
//  HDMainListHeaderView.m
//  HotDaily
//
//  Created by weizhou on 7/31/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "HDMainListHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@implementation HDMainListHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, 320, 200)];
    if (self) {
        [self pageViewInit];
        [self addSubview:self.pageView];
        
        [self pageControlInit];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)pageViewInit {
    self.pageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    self.pageView.pagingEnabled = YES;
    self.pageView.delegate = self;
    self.pageView.showsVerticalScrollIndicator = NO;
    self.pageView.showsHorizontalScrollIndicator = NO;
    self.pageView.contentSize = CGSizeMake(320*5, 200);
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*320, 0, 320, 200)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img3.laibafile.cn/p/m/184527856.jpg"]];
        
        [self insertMaskLayerTo:imageView.layer];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 300, 50)];
        title.textColor = [UIColor whiteColor];
        title.numberOfLines = 3;
        title.shadowColor = [UIColor blackColor];
        title.shadowOffset = CGSizeMake(1.0, 1.0);
        [imageView addSubview:title];
        
        title.text = @"test now";
        [self.pageView addSubview:imageView];
    }
    
    
}

- (void)insertMaskLayerTo:(CALayer *)layer {
    UIColor *color1 = [UIColor colorWithWhite:0.0 alpha:0.0];
    UIColor *color2 = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.frame = CGRectMake(0, 130, 320, 70);
    
    [layer insertSublayer:gradientLayer atIndex:0];
}

- (void)pageControlInit {
    self.pageControl = [UIPageControl new];
    self.pageControl.center = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height-10);
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat index = ceilf(scrollView.contentOffset.x / 320.0);
    NSLog(@"%f",index);
    self.pageControl.currentPage = index;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
