//
//  DIYScrollView.h
//  Scroll_test
//
//  Created by wangliang on 16/1/9.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIYScrollView : UIView

@property(nonatomic,strong)UIScrollView *BigScrollView;

//@property(nonatomic,strong)UIScrollView *SmallScrollView;


//轮播图的数组
@property(nonatomic,strong)NSMutableArray *imageArray;

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)imageArray;

@end
