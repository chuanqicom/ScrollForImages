//
//  DIYScrollView.m
//  Scroll_test
//
//  Created by wangliang on 16/1/9.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "DIYScrollView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DIYScrollView () <UIScrollViewDelegate>

@property(nonatomic,assign)BOOL isScroll;

@end

@implementation DIYScrollView

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray =  [NSMutableArray array];
    }

    return _imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.imageArray = imageArray;
        [self setScrollViewWithFrame:frame];

    }

    return self;
}

#pragma mark setScroll
- (void)setScrollViewWithFrame:(CGRect)frame
{
    self.BigScrollView = [[UIScrollView alloc]initWithFrame:frame];

    self.BigScrollView.contentSize = CGSizeMake(frame.size.width * self.imageArray.count, frame.size.height);
    //设置默认显示第一张
    self.BigScrollView.contentOffset = CGPointMake(0, 0);
    self.BigScrollView.delegate = self;
    //设置整屏翻动
    self.BigScrollView.pagingEnabled = YES;

    self.BigScrollView.directionalLockEnabled = YES;
    self.BigScrollView.bounces = NO;
    self.BigScrollView.showsHorizontalScrollIndicator = NO;
    self.BigScrollView.showsVerticalScrollIndicator = NO;

    //循环创建smallScrollView
    for (int i = 0; i<_imageArray.count; i++) {
        UIScrollView *small = [[UIScrollView alloc]initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];

        small.tag = 100 +i;
        small.delegate = self;
        small.minimumZoomScale = 0.5;
        small.maximumZoomScale = 2.0;
        small.bounces = YES;
        small.showsVerticalScrollIndicator = NO;
        small.showsHorizontalScrollIndicator = NO;

        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.imageArray[i]];
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        imageView.userInteractionEnabled = YES;

        //双击放大
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [imageView addGestureRecognizer:doubleTap];

        [small addSubview:imageView];
        [self.BigScrollView addSubview:small];

    }
    [self addSubview:_BigScrollView];

}

- (void)doubleTap:(UITapGestureRecognizer *)tap
{
    _isScroll = !_isScroll;

    UIImageView *imageView = (UIImageView *)tap.view;
    UIScrollView *small = (UIScrollView *)imageView.superview;

    if (_isScroll && small.zoomScale ==1) {

        small.zoomScale = 2.0 ;
        imageView.frame = CGRectMake(0, 0, kScreenWidth *2, kScreenHeight *2);
    }
    else
    {
        small.zoomScale = 1;
        imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
}

#pragma mark - Scrolldelegete
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{

    if (scrollView != self.BigScrollView) {
        return [scrollView.subviews objectAtIndex:0];
    }
    return nil;
}

//缩放
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.zoomScale < 1) {
        UIImageView *imageView = [scrollView.subviews objectAtIndex:0];

        imageView.center = CGPointMake(scrollView.bounds.size.width/2, scrollView.bounds.size.height/2);
        //    NSLog(@"  %@", NSStringFromCGRect(scrollView.frame));
        //    NSLog(@"--  %@", NSStringFromCGSize(scrollView.contentSize));
        //    NSLog(@"%@", NSStringFromCGRect([[scrollView.subviews objectAtIndex:0] frame]));
    }

}

//拖动到下一张图的时候，上一张图片状态被复原
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![_BigScrollView isEqual:scrollView]) {
        return;
    }

    for (UIScrollView *temoScrollView in scrollView.subviews) {
        if (temoScrollView.tag - 100 != _BigScrollView.contentOffset.x / kScreenWidth) {
            temoScrollView.zoomScale =1;
            UIImageView *imageView = [temoScrollView.subviews objectAtIndex:0];
            imageView.frame = temoScrollView.bounds;

        }
    }
}

@end
