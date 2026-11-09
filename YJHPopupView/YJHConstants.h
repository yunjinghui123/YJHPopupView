//
//  YJHConstants.h
//  YJHPopupViewDemo
//
//  Created by yunjinghui on 2026/11/9.
//  Copyright © 2026 yunjinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJHConstants : NSObject

@end

UIKIT_STATIC_INLINE
UIWindowScene *YJHGetWindowScene(void) {
    UIWindowScene *windowScene = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* wScene in [UIApplication sharedApplication].connectedScenes) {
            if (wScene.activationState == UISceneActivationStateForegroundActive) {
                windowScene = wScene;
                break;
            }
        }
    }
    return windowScene;
}

UIKIT_STATIC_INLINE
UIWindow *YJHGetRootWindow(void) {
    UIWindow *window = nil;
    if ([UIApplication.sharedApplication.delegate respondsToSelector:@selector(window)]) {
        //兼容新版项目结构，也就是AppDelegate没有window的情况
        window = UIApplication.sharedApplication.delegate.window;
    }
    if (window) {
        return window;
    }
    if (@available(iOS 13.0, *)) {
        UIWindowScene* wScene = YJHGetWindowScene();
        if (wScene) {
            window = wScene.windows.firstObject;
        }
    }
    return window;
}

UIKIT_STATIC_INLINE
UIViewController *YJHGetRootViewController(void) {
    UIViewController *rootViewController ;
    UIWindow *window = YJHGetRootWindow();
    if (window) {
        rootViewController = window.rootViewController;
        UIViewController *topVC = rootViewController;
        while (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        
        if (!topVC) { return nil; }
        rootViewController = topVC;
    }
    
    return rootViewController;
}

UIKIT_STATIC_INLINE
CGFloat YJHGetTabBarFullH(CGFloat baseTabBarHeight) {
    CGFloat bottom = YJHGetRootWindow().safeAreaInsets.bottom;
    if (bottom > 0) {
        return  baseTabBarHeight + YJHGetRootWindow().safeAreaInsets.bottom;
    } else {
        return baseTabBarHeight;
    }
}

