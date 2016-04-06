//
//  SecondViewController.m
//  Scroll_test
//
//  Created by wangliang on 16/1/9.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "SecondViewController.h"
#import "DIYScrollView.h"
@interface SecondViewController ()
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [NSMutableArray array];

    for (int i = 4; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [self.array addObject:image];
    }


    DIYScrollView *diy = [[DIYScrollView alloc]initWithFrame:self.view.bounds withArray:_array];

    [self.view addSubview:diy];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
