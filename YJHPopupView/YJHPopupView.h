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

@interface YJHPopupView : UIView


/// show popView
/// @param view super view
/// @param subView custom view
/// @param showFinish YJHPopupView showFinish
+ (instancetype)showToView:(UIView *)view subView:(UIView *)subView finish:(YJHPopShowFinished)showFinish;

/// hidden
- (void)hiddenView;

@end

NS_ASSUME_NONNULL_END
