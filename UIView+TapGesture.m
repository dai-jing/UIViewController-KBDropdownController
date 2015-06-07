//
//  UIView+TapGesture.m
//  KBDropdownController
//
//  Created by Jing Dai on 6/8/15.
//  Copyright (c) 2015 daijing. All rights reserved.
//

static void *kTapGestureKey = &kTapGestureKey;

#import "UIView+TapGesture.h"
#import <objc/runtime.h>

@implementation UIView (TapGesture)

- (void)setTapGestureWithBlock:(void (^)(void))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kTapGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kTapGestureKey);
        
        if (action) {
            action();
        }
    }
}

@end
