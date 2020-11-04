//
//  YJHPopupAnimation.h
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2020/11/4.
//  Copyright © 2020 yunjinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJHPopupCoder.h"

NS_ASSUME_NONNULL_BEGIN

///  base for animation coder
@interface YJHPopupAnimation : NSObject <YJHPopupCoder>
@end

/// Animation for ease，of subclass
@interface YJHPopupAnimationEase : YJHPopupAnimation
@end

/// Animation for bottom, of subclass
@interface YJHPopupAnimationFromBottom : YJHPopupAnimation
@end


NS_ASSUME_NONNULL_END
