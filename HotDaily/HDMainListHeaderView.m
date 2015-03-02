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
#import "HDMainListViewModel.h"

@implementation HDMainListHeaderView

- (instancetype)initWithViewModel:(HDMainListViewModel *)viewModel {
    _screenWidth = SCREEN_WIDTH;
    self = [self initWithFrame:CGRectMake(0, 0, _screenWidth, _screenWidth*5/8)];
    if (self) {
        self.viewModel = viewModel;
        
        [self pageViewInit];
        [self addSubview:self.pageView];
        
        [self pageControlInit];
        [self addSubview:self.pageControl];
        
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoSlide) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)autoSlide {
    if (self.pageControl.currentPage == 4) {
        [self.pageView scrollRectToVisible:CGRectMake(0, 0, self.screenWidth, self.screenWidth*5/8) animated:YES];
        self.pageControl.currentPage = 0;
        return;
    }
    self.pageControl.currentPage ++;
    [self.pageView scrollRectToVisible:CGRectMake(self.pageControl.currentPage*self.screenWidth, 0, self.screenWidth, self.screenWidth*5/8) animated:YES];
    
}

- (void)pageViewInit {
    self.pageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenWidth*5/8)];
    self.pageView.pagingEnabled = YES;
    self.pageView.delegate = self;
    self.pageView.bounces = NO;
    self.pageView.showsVerticalScrollIndicator = NO;
    self.pageView.showsHorizontalScrollIndicator = NO;
    self.pageView.contentSize = CGSizeMake(self.screenWidth*5, self.screenWidth*5/8);
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*self.screenWidth, 0, self.screenWidth, self.screenWidth*5/8)];
        [imageView sd_setImageWithURL:[self.viewModel headerImages][i][@"url"]];
        
        [self insertMaskLayerTo:imageView.layer];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, self.screenWidth*5/8 - 70, self.screenWidth-20, 50)];
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:20.0];
        title.numberOfLines = 2;
        title.shadowColor = [UIColor blackColor];
        title.shadowOffset = CGSizeMake(1.0, 1.0);
        [imageView addSubview:title];
        title.text = [self.viewModel headerImages][i][@"title"];
        [self.pageView addSubview:imageView];
    }
}

- (void)insertMaskLayerTo:(CALayer *)layer {
    UIColor *color1 = [UIColor colorWithWhite:0.0 alpha:0.0];
    UIColor *color2 = [UIColor colorWithWhite:0.0 alpha:0.3];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.frame = CGRectMake(0, self.screenWidth*5/8 - 70, self.screenWidth, 70);
    
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
    CGFloat index = scrollView.contentOffset.x / self.screenWidth;
    self.pageControl.currentPage = roundf(index);
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
