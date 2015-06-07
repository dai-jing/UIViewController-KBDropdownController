//
//  ViewController.m
//  KBDropdownController
//
//  Created by Jing Dai on 6/7/15.
//  Copyright (c) 2015 daijing. All rights reserved.
//

#import "ViewController.h"
#import "DropdownViewController.h"
#import "UIViewController+KBDropdownController.h"

@interface ViewController ()

@property (nonatomic, strong) DropdownViewController *dropdownVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    barButton.tag = kFoldButton;
    [barButton addTarget:self action:@selector(dropdownButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitle:@"Dropdown" forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [barButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.dropdownVC = [[DropdownViewController alloc] init];
}

- (void)dropdownButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == kFoldButton) {
        [self presentDropdownController:self.dropdownVC dropdownHeight:300 foldButton:button springAnimation:YES];
    } else if (button.tag == kUnfoldButton) {
        [self dismissDropdownController:self.dropdownVC dropdownHeight:300 foldButton:button];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
