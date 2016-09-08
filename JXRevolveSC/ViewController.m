//
//  ViewController.m
//  JXRevolveSC
//
//  Created by 吉祥 on 16/9/8.
//  Copyright © 2016年 jixiang. All rights reserved.
//

#import "ViewController.h"
#import "JXRevolveImageView.h"

@interface ViewController ()<JXRevolveImageViewDelegate>

@property (nonatomic,weak) JXRevolveImageView *RevolveImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imgNames = @[@"http://www.dns001.com/uploads/allimg/160403/19292I293-3.jpg",
                          
                          @"http://img.wallpapersking.com/800/2012-8/20120812103710.jpg",
                          
                          @"http://www.517europe.com.cn/upload/2014/08/201408061251224341.jpg",
                          
                          @"http://test.beiguoyou.com/upfiles/2014-11-26/e81864232f494af3986d0bcd10325afc0.jpg",
                          
                          @"http://www.xcghj.gov.cn/upimage/20131127142139.JPG"
                          ];
    
    JXRevolveImageView *RevolveImageView = [[JXRevolveImageView alloc] initWithFrame:CGRectMake(10, 74, self.view.bounds.size.width - 2 * 10, 200) withBannerSource:JXBannerStyleOnlyWebSource withBannerArray:imgNames];
    
    RevolveImageView.showPageControl = YES;
    RevolveImageView.delegate = self;
    RevolveImageView.timeInterval = 1.5;
    [self.view addSubview:RevolveImageView];
    self.RevolveImageView = RevolveImageView;

}

-(void)jxRevolveImageView:(JXRevolveImageView *)RevolveImageView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld张图片",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
