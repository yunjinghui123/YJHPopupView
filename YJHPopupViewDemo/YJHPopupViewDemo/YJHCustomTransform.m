//
//  YJHCustomTransform.m
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2020/11/4.
//  Copyright © 2020 yunjinghui. All rights reserved.
//

#import "YJHCustomTransform.h"
//#import "YJHPopupView.h"

@implementation YJHCustomTransform
@synthesize contentView;
@synthesize popView;

- (void)animationShowFinish:(BOOL)finished {
    self.contentView.transform = CGAffineTransformIdentity;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenView];
    });

}

- (void)hiddenFromViewFinish {
    
}

- (void)hiddenView {
    [self.popView removeFromSuperview];
    [self.contentView removeFromSuperview];
    self.popView.hiddenFinish();
}

- (void)showPopViewAnimation {
    
    CGFloat tx = UIScreen.mainScreen.bounds.size.width - self.contentView.frame.size.width;
    [UIView animateWithDuration:0.8 animations:^{
        self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, tx, 0);
        } completion:^(BOOL finished) {
            [self animationShowFinish:finished];
        }];
}

@end
