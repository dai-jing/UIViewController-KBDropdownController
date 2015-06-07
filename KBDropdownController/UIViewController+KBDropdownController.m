//
// UIViewController+KBDropdownController.m
//
// Copyright (c) 2015 Kobe Dai. All rights reserved.
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

static void *DimViewKey = &DimViewKey;

#import "UIViewController+KBDropdownController.h"
#import "UIView+TapGesture.h"
#import <objc/objc-runtime.h>

@implementation UIViewController (KBDropdownController)

- (void)setDimView:(UIView *)dimView
{
    objc_setAssociatedObject(self, &DimViewKey, dimView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dimView
{
    return objc_getAssociatedObject(self, &DimViewKey);
}

- (void)presentDropdownController:(UIViewController *)dropdownController dropdownHeight:(CGFloat)height foldButton:(UIButton *)button springAnimation:(BOOL)animated
{
    button.tag = kUnfoldButton;
    button.enabled = NO;
    [self showDropdownController:dropdownController dropdownHeight:height foldButton:button springAnimation:animated];
}

- (void)dismissDropdownController:(UIViewController *)dropdownController dropdownHeight:(CGFloat)height foldButton:(UIButton *)button
{
    button.tag = kFoldButton;
    button.enabled = NO;
    [self hideDropdownController:dropdownController dropdownHeight:height foldButton:button];
}

- (void)showDropdownController:(UIViewController *)dropdownController dropdownHeight:(CGFloat)height foldButton:(UIButton *)button springAnimation:(BOOL)animated
{
    __weak typeof(self) weakSelf = self;
    
    self.dimView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.dimView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.4];
    [self.dimView setTapGestureWithBlock:^{
        [weakSelf dismissDropdownController:dropdownController dropdownHeight:height foldButton:button];
    }];
    [UIView transitionWithView:self.view
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [weakSelf.view addSubview:weakSelf.dimView];
                    } completion:^(BOOL finished) {
                        [weakSelf addChildViewController:dropdownController];
                        dropdownController.view.frame = CGRectMake(0, -height, CGRectGetWidth(weakSelf.view.frame), height);
                        [weakSelf.view addSubview:dropdownController.view];
                        [dropdownController didMoveToParentViewController:weakSelf];
                        
                        if (animated) {
                            [UIView animateWithDuration:0.5f
                                                  delay:0.f
                                 usingSpringWithDamping:0.6f
                                  initialSpringVelocity:0.8f
                                                options:UIViewAnimationOptionCurveEaseInOut
                                             animations:^{
                                                 dropdownController.view.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.view.frame), height);
                                             } completion:^(BOOL finished) {
                                                 button.enabled = YES;
                                             }];
                        } else {
                            [UIView animateWithDuration:0.2f
                                             animations:^{
                                                 dropdownController.view.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.view.frame), height);
                                             } completion:^(BOOL finished) {
                                                 button.enabled = YES;
                                             }];
                        }
                    }];
}

- (void)hideDropdownController:(UIViewController *)dropdownController dropdownHeight:(CGFloat)height foldButton:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;
    [UIView transitionWithView:self.view
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [weakSelf.dimView removeFromSuperview];
                        weakSelf.dimView = nil;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.2f
                                         animations:^{
                                            dropdownController.view.frame = CGRectMake(0, -height, CGRectGetWidth(weakSelf.view.frame), height);
                                         } completion:^(BOOL finished) {
                                             [dropdownController.view removeFromSuperview];
                                             [dropdownController removeFromParentViewController];
                                             [dropdownController didMoveToParentViewController:nil];
                                             button.enabled = YES;
                                         }];
                    }];
}

@end
