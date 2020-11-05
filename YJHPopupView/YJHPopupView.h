//
//  YJHPopupView.h
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2019/10/22.
//  Copyright © 2019 yunjinghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJHPopupAnimation.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^YJHPopShowFinished)(void);
typedef void (^YJHPopHiddenFinished)(void);

@interface YJHPopupView : UIView
/**
 添加的subview必须要设置frame，否则子视图不会展示
 子视图frame为视图完全展示的frame
 注意：
 1、如果想在popview展示完成的时候为subview添加子视图，建议使用懒加载方式加载，不然会多次创建。
 2、如果不使用懒加载，请在hiddenFinsh中自己手动移除子视图
 
 
 The added subview must have a frame set, Otherwise the subview will not show.
 The subview frame is the frame that the view is fully displayed.
 note:
   1. If you want to add subviews to the subview when the popview is displayed, it is recommended to use lazy loading, otherwise it will be created multiple times.
   2. If you do not use lazy loading, please manually remove the subview in hiddenFinsh
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
+ (instancetype)showToWindowWithSubView:(UIView *)subView popShowAnimation:(id<YJHPopupCoder>)animationCoder;
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView popShowAnimation:(id<YJHPopupCoder>)animationCoder;

/// hidden
- (void)hiddenView;

@end

NS_ASSUME_NONNULL_END
