//
//  YJHPopupView.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import "YJHPopupView.h"

/// The view must be run in main thread.
#define YJHMainThreadAssert()    NSAssert([NSThread isMainThread], @"YJHPopupView needs to be accessed on the main thread.");
#define YJHBackViewAssert(view)  NSAssert(!(CGSizeEqualToSize(view.bounds.size, CGSizeZero)), @"YJHPopView super view can not CGSizeZero");

/// animation duration
static const CGFloat YJHPOPUPVIEW_ANIMATION_TIME = 0.25;

@interface YJHPopupView () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) YJHPopupView *popView;
@property (nonatomic, assign) YJHPopShowViewAnimation animation;
@end

@implementation YJHPopupView {
    UITapGestureRecognizer *_tap;
}

- (instancetype)init {
    if (self = [super init]) {
        self.animation = YJHPopShowViewAnimationEase;
        self.isUseBackTapGesture = YES;
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
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
    [self addBackGroundTapHiddenGesture];
}

- (void)addBackGroundTapHiddenGesture {
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    _tap.delegate = self;
    [self addGestureRecognizer:_tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

- (void)setIsUseBackTapGesture:(BOOL)isUseBackTapGesture {
    _isUseBackTapGesture = isUseBackTapGesture;
    if (!isUseBackTapGesture) {
        [self removeGestureRecognizer:_tap];
    }
}

#pragma mark - public: show view
+ (instancetype)showToWindowWithSubView:(UIView *)subView {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView];
}
/// show popupView
/// @param view super view
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView {
    return [self showToView:view subView:subView popShowAnimation:YJHPopShowViewAnimationEase];
}

+ (instancetype)showToWindowWithSubView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView popShowAnimation:animation];
}

+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation {
    YJHMainThreadAssert()
    YJHBackViewAssert(view)
    YJHPopupView *popView = [[self alloc] initWithFrame:view.bounds];
    [view addSubview:popView];
    [popView addSubview:subView];
    
    popView.popView = popView;
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
    self.contentView.frame = CGRectMake(0, self.popView.bounds.size.height, self.popView.bounds.size.width, contentViewH);
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.popView.alpha = 1.f;
        self.contentView.frame = CGRectMake(0, contentViewY, self.popView.bounds.size.width, contentViewH);
    } completion:^(BOOL finished) {
        [self animationShowFinish:finished];
    }];
}

/// ease show animation
- (void)showEaseAnimation {
    self.popView.alpha = 0;
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.popView.alpha = 1;
    } completion:^(BOOL finished) {
        [self animationShowFinish:finished];
    }];
}

/// show finish callback
- (void)animationShowFinish:(BOOL)finished {
    if (finished) {
        if (self.showFinish) {
            self.showFinish();
        }
    }
}

/// bottom hidden animation
- (void)hiddenFromBottonAnimation {
    self.popView.alpha = 1.f;
    CGFloat contentViewY = self.contentView.frame.origin.y;
    CGFloat contentViewH = self.contentView.frame.size.height;
    self.contentView.frame = CGRectMake(0, contentViewY, self.popView.bounds.size.width, contentViewH);
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.contentView.frame = CGRectMake(0, self.popView.bounds.size.height, self.popView.bounds.size.width, contentViewH);
    } completion:^(BOOL finished) {
        self.popView.alpha = 0.f;
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

/// hidden view
- (void)hiddenFromView {
    YJHMainThreadAssert()
    [self removeFromSuperview];
    [self.contentView removeFromSuperview];
    if (self.hiddenFinish) {
        self.hiddenFinish();
    }
}


@end
