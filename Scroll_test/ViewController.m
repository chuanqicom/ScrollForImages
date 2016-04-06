//
//  ViewController.m
//  Scroll_test
//
//  Created by wangliang on 16/1/9.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)jumpToNext:(id)sender {

    SecondViewController *second = [[SecondViewController alloc]init];
    [self presentViewController:second animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
