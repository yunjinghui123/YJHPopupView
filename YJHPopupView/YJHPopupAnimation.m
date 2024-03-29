//
//  YJHPopupAnimation.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2020/11/4.
//  Copyright © 2020 yunjinghui. All rights reserved.
//

#import "YJHPopupAnimation.h"
#import "YJHPopupView.h"

/// animation duration
static const CGFloat YJHPOPUPVIEW_ANIMATION_TIME = 0.25;

@implementation YJHPopupAnimation
@synthesize popView;
@synthesize contentView;
/// show view
- (void)showPopViewAnimation {}
- (void)animationShowFinish:(BOOL)finished {
    if (finished && self.popView.showFinish) {
        self.popView.showFinish();
    }
}

/// hidden view
- (void)hiddenView {}
- (void)hiddenFromViewFinish {
    YJHMainThreadAssert();
    @autoreleasepool {
        [self.popView removeFromSuperview];
        [self.contentView removeFromSuperview];
    }
    if (self.popView.hiddenFinish) {
        self.popView.hiddenFinish();
    }
}
@end

/// Ease
@implementation YJHPopupAnimationEase
- (void)showPopViewAnimation {
    self.popView.alpha = 0.f;
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME
                     animations:^{
        self.popView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [self animationShowFinish:finished];
    }];
}

- (void)hiddenView {
    self.popView.alpha = 1;
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.popView.alpha = 0;
    } completion:^(BOOL finished) {
        [self hiddenFromViewFinish];
    }];
}

@end

@implementation YJHPopupAnimationFromBottom
/// bottom show animation
- (void)showPopViewAnimation {
    self.popView.alpha = 0.f;
    CGFloat contentViewY = self.contentView.frame.origin.y;
    self.contentView.frame = (CGRect){{0, self.popView.bounds.size.height}, self.contentView.bounds.size};
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME
                     animations:^{
        self.popView.alpha = 1.f;
        self.contentView.frame = (CGRect){{0, contentViewY}, self.contentView.bounds.size};
    } completion:^(BOOL finished) {
        [self animationShowFinish:finished];
    }];
}

- (void)hiddenView {
    self.popView.alpha = 1.f;
    CGFloat contentViewY = self.contentView.frame.origin.y;
    self.contentView.frame = (CGRect){{0, contentViewY}, self.contentView.bounds.size};
    [UIView animateWithDuration:YJHPOPUPVIEW_ANIMATION_TIME animations:^{
        self.contentView.frame = (CGRect){{0, self.popView.bounds.size.height}, self.contentView.bounds.size};
    } completion:^(BOOL finished) {
        self.popView.alpha = 0.f;
        [self hiddenFromViewFinish];
        self.contentView.frame = (CGRect){{0, contentViewY}, self.contentView.bounds.size};
    }];
}
@end


/// Animation for right
@implementation YJHPopupAnimationFromRight
/// bottom show animation
- (void)showPopViewAnimation {
    self.popView.alpha = 0.f;
    CGFloat contentViewX = self.contentView.frame.origin.x;
    self.contentView.frame = (CGRect){{self.popView.bounds.size.width, 0}, self.contentView.bounds.size};
    [UIView animateWithDuration:0.25
                     animations:^{
        self.popView.alpha = 1.f;
        self.contentView.frame = (CGRect){{contentViewX, 0}, self.contentView.bounds.size};
    } completion:^(BOOL finished) {
        [self animationShowFinish:finished];
    }];
}

- (void)hiddenView {
    self.popView.alpha = 1.f;
    CGFloat contentViewX = self.contentView.frame.origin.x;
    self.contentView.frame = (CGRect){{contentViewX, 0}, self.contentView.bounds.size};
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = (CGRect){{self.popView.bounds.size.width, 0}, self.contentView.bounds.size};
    } completion:^(BOOL finished) {
        self.popView.alpha = 0.f;
        [self hiddenFromViewFinish];
    }];
}

@end
