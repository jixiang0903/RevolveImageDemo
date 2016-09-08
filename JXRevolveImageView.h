//
//  JXRevolveImageView.h
//  JXRevolveSC
//
//  Created by 吉祥 on 16/9/8.
//  Copyright © 2016年 jixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXRevolveImageView;
//图片来源
typedef NS_ENUM(NSInteger , JXBannerSource) {

    JXBannerStyleOnlyLocalSource = 0,
    JXBannerStyleOnlyWebSource = 1,
};
@protocol JXRevolveImageViewDelegate <NSObject>

-(void)jxRevolveImageView:(JXRevolveImageView *)RevolveImageView didSelectItemAtIndex:(NSInteger)index;

@end

@interface JXRevolveImageView : UIView

@property(nonatomic,weak)id<JXRevolveImageViewDelegate> delegate;

@property(nonatomic,assign) CGFloat timeInterval;
@property(nonatomic,assign) BOOL showPageControl;

@property (nonatomic,strong) UIColor *currentPageIndicatorTintColour;
@property (nonatomic,strong) UIColor *pageIndicatorTintColour;

-(instancetype)initWithFrame:(CGRect)frame withBannerSource:(JXBannerSource )bannerSource withBannerArray:(NSArray *)bannerArray;

@end
