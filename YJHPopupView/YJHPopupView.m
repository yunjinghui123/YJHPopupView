//
//  YJHPopupView.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import "YJHPopupView.h"

@interface YJHPopupView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *contentView;
@end

@implementation YJHPopupView

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubViews];
    }
    return self;
}

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    [self addBackGroundTapHiddenGesture];
}

- (void)addBackGroundTapHiddenGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

/// show popupView
/// @param view super view
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView finish:(YJHPopShowFinished)showFinish {
    YJHPopupView *popView = [[YJHPopupView alloc] initWithFrame:view.bounds];
    [view addSubview:popView];
    [popView addSubview:subView];
    
    popView.contentView = subView;
    
    popView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        popView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if (showFinish) {
                showFinish();
            }
        }
    }];

    return popView;
}

/// hidden
- (void)hiddenView {
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self hiddenFromView:self];
    }];
}

- (void)hiddenFromView:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subView isKindOfClass:[UIView class]]) {
            [subView removeFromSuperview];
        }
    }];
}



@end
