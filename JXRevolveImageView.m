//
//  JXRevolveImageView.m
//  JXRevolveSC
//
//  Created by 吉祥 on 16/9/8.
//  Copyright © 2016年 jixiang. All rights reserved.
//

#import "JXRevolveImageView.h"
#import "UIImageView+WebCache.h"

@interface JXRevolveImageView ()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) NSArray *imageArray;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation JXRevolveImageView

{
    CGFloat selfWidth;
    CGFloat selfHeight;
    NSInteger totalNumber;
    NSInteger currentPage;
    NSMutableArray *bannerImageArray;
    NSInteger bannerSourceType;
    
}

-(instancetype)initWithFrame:(CGRect)frame withBannerSource:(JXBannerSource)bannerSource withBannerArray:(NSArray *)bannerArray{
    if (self = [super initWithFrame:frame]) {
        selfWidth = frame.size.width;
        selfHeight = frame.size.height;
        totalNumber = bannerArray.count;
        currentPage = 0;
        _imageArray = bannerArray;
        bannerSourceType = bannerSource;
    }
    self.imageArray = bannerArray;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.imageView];
    
    self.imageView.userInteractionEnabled = YES;
    
    if (bannerSourceType == 0) {
        
        self.imageView.image = [UIImage imageNamed:self.imageArray[currentPage]];
        
        
    }else if (bannerSourceType == 1){
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[currentPage]]];
        
    }
    
    UISwipeGestureRecognizer *swipeGestureR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight)];
    [swipeGestureR setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.imageView addGestureRecognizer:swipeGestureR];
    
    UISwipeGestureRecognizer *swipeGestureL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft)];
    
    [swipeGestureL setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.imageView addGestureRecognizer:swipeGestureL];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    
    [self.imageView addGestureRecognizer:tapRecognizer];
    
    [self setUpTimer:5];

    return self;
}

- (void)setPageIndicatorTintColour:(UIColor *)pageIndicatorTintColour {
    
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColour;
    
}

- (void)setCurrentPageIndicatorTintColour:(UIColor *)currentPageIndicatorTintColour {
    
    self.pageControl.currentPage = currentPage;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    
    if (showPageControl == YES) {
        
        [self addSubview:self.pageControl];
    }
    
}
- (UIPageControl *)pageControl {
    
    if (_pageControl == nil) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = totalNumber;
        CGSize size = [_pageControl sizeForNumberOfPages:totalNumber];
        _pageControl.frame = CGRectMake(0, 200, size.width, size.height);
        _pageControl.center = CGPointMake(self.center.x + 120, selfHeight - 18);
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.hidesForSinglePage = YES;
        
    }
    
    return _pageControl;
}



- (void)handleSwipeFromRight {
    
    currentPage++;
    
    if (currentPage >= self.imageArray.count) {
        
        currentPage = 0;
    }
    
    self.pageControl.currentPage = currentPage;
    
    if (bannerSourceType == 0) {
        
        self.imageView.image = [UIImage imageNamed:self.imageArray[currentPage]];
    }else if (bannerSourceType == 1) {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[currentPage]]];
        
    }
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.5;
    transition.delegate = self;
    
    [self.imageView.layer addAnimation:transition forKey:nil];
}

- (void)handleSwipeFromLeft {
    
    currentPage--;
    
    if (currentPage < 0) {
        
        currentPage = self.imageArray.count - 1;
        
    }
    self.pageControl.currentPage = currentPage;
    
    if (bannerSourceType == 0) {
        
        self.imageView.image = [UIImage imageNamed:self.imageArray[currentPage]];
    }else if (bannerSourceType == 1) {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[currentPage]]];
        
    }
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 1.5;
    transition.delegate = self;
    
    [self.imageView.layer addAnimation:transition forKey:nil];
    
}

- (void)setTimeInterval:(CGFloat)timeInterval {
    
    _timeInterval = fabs(timeInterval);
    
    if (self.timer) {
        
        [self.timer invalidate];
        
        [self setUpTimer:_timeInterval];
    }
    
    
    
}

- (void)setUpTimer:(CGFloat )timerInterval {
    
    self.timer = [NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(handleSwipeFromRight) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    
}

- (void)animationDidStart:(CAAnimation *)anim {
    
    if (self.timer) {
        
        [self.timer invalidate];
        
    }
    
    self.imageView.userInteractionEnabled = NO;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.timeInterval > 0) {
        
        [self setUpTimer:self.timeInterval];
    }else {
        
        [self setUpTimer:5.0];
    }
    
    self.imageView.userInteractionEnabled = YES;
    
    
}
- (void)tapImageView {
    
    if ([self.delegate respondsToSelector:@selector(jxRevolveImageView:didSelectItemAtIndex:)]) {
        
        [self.delegate jxRevolveImageView:self didSelectItemAtIndex:currentPage];
        
    }
    
}

@end
