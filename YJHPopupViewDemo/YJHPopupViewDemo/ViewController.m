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
@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *backView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
}
- (IBAction)buttonA:(id)sender {
//    [self testWindow];
//    [self testView];
    [self customView];
}

- (void)customView {
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    redView.frame = CGRectMake(150, 300, 100, 100);
    [self.view addSubview:redView];
    
    YJHPopupView *popView = [YJHPopupView showToView:redView subView:self.yellowView];
    popView.showFinish = ^{};
    popView.backgroundColor = UIColor.cyanColor;
    //    popView.isUseBackTapGesture = NO;
    popView.hiddenFinish = ^{
        NSLog(@"hidden");
    };

    [self popviewSet:popView];
}


- (void)testView {
    YJHPopupView *popView = [YJHPopupView showToView:self.view subView:self.backView];
    [self popviewSet:popView];
}


- (void)testWindow {
    YJHPopupView *popView = [YJHPopupView showToWindowWithSubView:self.backView];
    [self popviewSet:popView];
}

- (void)popviewSet:(YJHPopupView *)popView {
    popView.showFinish = ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.backView addSubview:self.yellowView];
//        });
    };
    popView.backgroundColor = UIColor.cyanColor;
//    popView.isUseBackTapGesture = NO;
    popView.hiddenFinish = ^{
        NSLog(@"hidden");
    };
}


- (UIView *)backView {
    if (_backView == nil) {
        CGFloat height = 150;
        CGFloat y = [UIScreen mainScreen].bounds.size.height - height;
        CGFloat x = 0;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _backView.backgroundColor = UIColor.redColor;
    }
    return _backView;
}

- (UIView *)yellowView {
    if (_yellowView == nil) {
        _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _yellowView.backgroundColor = UIColor.yellowColor;
    }
    return _yellowView;
}


@end
