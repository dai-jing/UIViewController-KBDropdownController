UIViewController-KBDropdownController
==================================
![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)

Simple UIViewController category to present custom dropdown controller.

## Introduction
Present dropdown controller needs lots of works to deal with child view controller and animations. This UIViewController category make this simple to deal with and has a smooth spring animation and a dim view with alpha value.

## Screenshots
![KBDropdownControllerDemo1](https://cloud.githubusercontent.com/assets/2702996/8025385/2fe4b588-0d87-11e5-95c8-ae1c187bb5b2.png)

## CocoaPods - Try it yourself
`pod 'UIViewController+KBDropdownController'`

## Example
import this category
`#import <UIViewController+KeyboardAnimation.h>`

Make your button selector like this:
```
- (void)dropdownButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == kFoldButton) {
        [self presentDropdownController:self.dropdownVC dropdownHeight:300 foldButton:button springAnimation:YES];
    } else if (button.tag == kUnfoldButton) {
        [self dismissDropdownController:self.dropdownVC dropdownHeight:300 foldButton:button];
    }
}
```
