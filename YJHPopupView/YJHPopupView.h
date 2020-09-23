//
//  YJHPopupView.h
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^YJHPopShowFinished)(void);
typedef void (^YJHPopHiddenFinished)(void);

typedef NS_ENUM(NSInteger, YJHPopShowViewAnimation) {
    YJHPopShowViewAnimationNone       = 1 << 0,
    YJHPopShowViewAnimationEase       = 1 << 1,
    YJHPopShowViewAnimationFromBottom = 1 << 2
};

@interface YJHPopupView : UIView

/**
 添加的subview必须要设置frame，否则子视图不会展示
 子视图frame为视图完全展示的frame
 
 The added subview must have a frame set, Otherwise the subview will not show.
 The subview frame is the frame that the view is fully displayed.
 */

/// whether to respond to background gesture. default YES
@property (nonatomic, assign) BOOL isUseBackTapGesture;
/// view hidden finish
@property (nonatomic, copy, nullable) YJHPopHiddenFinished hiddenFinish;
/// view show finish
@property (nonatomic, copy, nullable) YJHPopShowFinished   showFinish;

/// show popView, default YJHPopShowViewAnimationEase
/// view super view
/// subView custom view. you must create a custom view when you call that func, because when view hidden, this subview will be remove from superview
/// showFinish YJHPopupView showFinish
+ (instancetype)showToWindowWithSubView:(UIView *)subView;
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView;

/// you can specify an animated style
+ (instancetype)showToWindowWithSubView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation;
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation;

/// hidden
- (void)hiddenView;

@end

NS_ASSUME_NONNULL_END
