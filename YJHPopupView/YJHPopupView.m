//
//  YJHPopupView.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import "YJHPopupView.h"

/// 动画展示消失时间
static const CGFloat YJHPOPUPVIEW_ANIMATION_TIME = 0.25;

@interface YJHPopupView () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) YJHPopupView *popView;
@property (nonatomic, copy)   YJHPopShowFinished showFinish;
@property (nonatomic, assign) YJHPopShowViewAnimation animation;
@end

@implementation YJHPopupView

- (instancetype)init {
    if (self = [super init]) {
        self.animation = YJHPopShowViewAnimationEase;
        [self setupSubViews];
    }
    return self;
}

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.animation = YJHPopShowViewAnimationEase;
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

#pragma mark - public: show view
+ (instancetype)showToWindowWithSubView:(UIView *)subView {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView finish:nil];
}

+ (instancetype)showToWindowWithSubView:(UIView *)subView finish:(YJHPopShowFinished)showFinish {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView finish:showFinish];
}

/// show popupView
/// @param view super view
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView finish:(YJHPopShowFinished)showFinish {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView popShowAnimation:YJHPopShowViewAnimationFromBottom finish:showFinish];
}

+ (instancetype)showToWindowWithSubView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView popShowAnimation:animation finish:nil];
}

+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation finish:(YJHPopShowFinished)showFinish {
    YJHPopupView *popView = [[self alloc] initWithFrame:view.bounds];
    [view addSubview:popView];
    [popView addSubview:subView];
    
    popView.popView = popView;
    popView.showFinish = showFinish;
    popView.contentView = subView;
    popView.animation = animation;
    
    [popView showPopViewAnimation];
    return popView;
}

#pragma mark - public: hidden view
- (void)hiddenView {
    if (self.animation == YJHPopShowViewAnimationEase) {
        [self hiddenEaseView];
    } else if (self.animation == YJHPopShowViewAnimationFromBottom) {
        [self hiddenFromBottonAnimation];
    }
}

#pragma mark - private show & hidden
/// show animation
- (void)showPopViewAnimation {
    if (self.animation == YJHPopShowViewAnimationEase) {
        [self showEaseAnimation];
    } else if (self.animation == YJHPopShowViewAnimationFromBottom) {
        [self showFromBottonAnimation];
    }
}

#pragma mark - private func: show animation & hidden animation
/// bottom show animation
- (void)showFromBottonAnimation {
    self.popView.alpha = 0.f;
    CGFloat contentViewY = self.contentView.frame.origin.y;
    CGFloat contentViewH = self.contentView.frame.size.height;
    self.contentView.frame = CGRectMake(0, self.popView.frame.size.height, self.popView.frame.size.width, contentViewH);
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.popView.alpha = 1.f;
        self.contentView.frame = CGRectMake(0, contentViewY, self.popView.frame.size.width, contentViewH);
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.showFinish) {
                self.showFinish();
            }
        }
    }];
}

/// ease show animation
- (void)showEaseAnimation {
    self.popView.alpha = 0;
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.popView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.showFinish) {
                self.showFinish();
            }
        }
    }];
}

/// bottom hidden animation
- (void)hiddenFromBottonAnimation {
    self.popView.alpha = 1.f;
    CGFloat contentViewY = self.contentView.frame.origin.y;
    CGFloat contentViewH = self.contentView.frame.size.height;
    self.contentView.frame = CGRectMake(0, contentViewY, self.popView.frame.size.width, contentViewH);
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.popView.alpha = 0.f;
        self.contentView.frame = CGRectMake(0, self.popView.frame.size.height, self.popView.frame.size.width, contentViewH);
    } completion:^(BOOL finished) {
        [self hiddenFromView];
    }];
}

/// ease hidden animation
- (void)hiddenEaseView {
    self.alpha = 1;
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self hiddenFromView];
    }];
}

/// 隐藏视图
- (void)hiddenFromView {
    [self removeFromSuperview];
    [self.contentView removeFromSuperview];
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([subView isKindOfClass:[UIView class]]) {
//            [subView removeFromSuperview];
//        }
//    }];
}


@end
