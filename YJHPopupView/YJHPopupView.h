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

typedef NS_ENUM(NSInteger, YJHPopShowViewAnimation) {
    YJHPopShowViewAnimationEase       = 1 << 0,
    YJHPopShowViewAnimationFromBottom = 1 << 1
};

@interface YJHPopupView : UIView

/**
 添加的subview必须要设置frame，否则子视图不会展示
 子视图frame为视图完全展示的frame
 
 The added subview must have a frame set, Otherwise the subview will not show.
 The subview frame is the frame that the view is fully displayed.
 */
/// show popView, default YJHPopShowViewAnimationEase
/// view super view
/// subView custom view
/// showFinish YJHPopupView showFinish
+ (instancetype)showToWindowWithSubView:(UIView *)subView;
+ (instancetype)showToWindowWithSubView:(UIView *)subView finish:(nullable YJHPopShowFinished)showFinish;
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView finish:(nullable YJHPopShowFinished)showFinish;

/// you can specify an animated style
+ (instancetype)showToWindowWithSubView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation;
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView popShowAnimation:(YJHPopShowViewAnimation)animation finish:(nullable YJHPopShowFinished)showFinish;

/// hidden
- (void)hiddenView;

@end

NS_ASSUME_NONNULL_END
