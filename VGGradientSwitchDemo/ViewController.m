//
//  ViewController.m
//  VGGradientSwitchDemo
//
//  Created by Vein on 2017/2/12.
//  Copyright © 2017年 gwr. All rights reserved.
//

#import "ViewController.h"
#import "VGGradientSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VGGradientSwitch *switchButton = [[VGGradientSwitch alloc] initWithFrame:CGRectMake(0, 0, 30*1.75, 30)];
    switchButton.center = self.view.center;
    [switchButton setOn:NO animated:YES];
    switchButton.action = ^(BOOL isOn){
        NSLog(@"%@",isOn?@"打开":@"关闭");
    };
    [self.view addSubview:switchButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
