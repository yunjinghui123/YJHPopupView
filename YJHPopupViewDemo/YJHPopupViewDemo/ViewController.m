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
    CGFloat height = 150;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - height;
    CGFloat x = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    view.backgroundColor = UIColor.redColor;
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view1.backgroundColor = UIColor.yellowColor;
    
    YJHPopupView *popView = [YJHPopupView showToWindowWithSubView:view finish:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view addSubview:view1];
        });
    }];
    popView.backgroundColor = UIColor.cyanColor;
    popView.isUseBackTapGesture = NO;

}


@end
