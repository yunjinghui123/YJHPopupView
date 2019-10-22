//
//  ViewController.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import "ViewController.h"
#import "YJHPopupView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 100, 100, 100);
    button.hidden = YES;
    
    YJHPopupView *popView = [YJHPopupView showToView:[UIApplication sharedApplication].keyWindow subView:button finish:^{
        button.hidden = NO;
    }];
    popView.backgroundColor = UIColor.cyanColor;

}


@end
