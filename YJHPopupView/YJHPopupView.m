//
//  YJHPopupView.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import "YJHPopupView.h"
#import "YJHPopupAnimation.h"

@interface YJHPopupView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong, nonnull) id<YJHPopupCoder> animationCoder;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
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
    self.isUseBackTapGesture = YES;
    self.animationCoder = [[YJHPopupAnimationEase alloc] init];
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
    [self addBackGroundTapHiddenGesture];
}

- (void)addBackGroundTapHiddenGesture {
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    _tapGesture.delegate = self;
    [self addGestureRecognizer:_tapGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.animationCoder.contentView]) {
        return NO;
    }
    return YES;
}

- (void)setIsUseBackTapGesture:(BOOL)isUseBackTapGesture {
    _isUseBackTapGesture = isUseBackTapGesture;
    if (!isUseBackTapGesture) {
        [self removeGestureRecognizer:_tapGesture];
    }
}

#pragma mark - public: show view
+ (instancetype)showToWindowWithSubView:(UIView *)subView {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView];
}
/// show popupView
/// @param view super view
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView {
    return [self showToView:view subView:subView popShowAnimation:[YJHPopupAnimationEase new]];
}

+ (instancetype)showToWindowWithSubView:(UIView *)subView popShowAnimation:(id<YJHPopupCoder>)animationCoder {
    return [self showToView:[UIApplication sharedApplication].windows.firstObject subView:subView popShowAnimation:animationCoder];;
}

+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView popShowAnimation:(id<YJHPopupCoder>)animationCoder {
    YJHMainThreadAssert()
    YJHBackViewAssert(view)
    YJHPopupView *popView = [[self alloc] initWithFrame:view.bounds];
    [view addSubview:popView];
    [popView addSubview:subView];
    
    popView.animationCoder = animationCoder;
    popView.animationCoder.popView = popView;
    popView.animationCoder.contentView = subView;
    
    // animation
    [popView.animationCoder showPopViewAnimation];
    return popView;
}

#pragma mark - public: hidden view
- (void)hiddenView {
    [self.animationCoder hiddenView];
}

- (void)dealloc {
    [self removeGestureRecognizer:_tapGesture];
}

@end
