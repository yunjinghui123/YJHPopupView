//
//  YJHPopupCoder.h
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2020/11/4.
//  Copyright © 2020 yunjinghui. All rights reserved.
//

#ifndef YJHPopupCoder_h
#define YJHPopupCoder_h
#import <UIKit/UIKit.h>
@class YJHPopupView;

/// The view must be run in main thread.
#define YJHMainThreadAssert()    NSAssert([NSThread isMainThread], @"YJHPopupView needs to be accessed on the main thread.");
#define YJHBackViewAssert(view)  NSAssert(!(CGSizeEqualToSize(view.bounds.size, CGSizeZero)), @"YJHPopView super view can not CGSizeZero");

@protocol YJHPopupCoder <NSObject>
@required
@property (nonatomic, weak, nullable) UIView *contentView;
@property (nonatomic, weak, nullable) YJHPopupView *popView;
///  show popview
- (void)showPopViewAnimation;
///  hidden popview
- (void)hiddenView;

@optional
/// callback of hidden finish
- (void)hiddenFromViewFinish;
/// callback of show finish
- (void)animationShowFinish:(BOOL)finished;

@end

#endif /* YJHPopupCoder_h */
