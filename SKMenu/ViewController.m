//
//  ViewController.m
//  SKMenu
//
//  Created by sk on 2018/8/21.
//  Copyright © 2018 sk. All rights reserved.
//

#import "ViewController.h"
#import "FloatPartHeader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FloatPartView * menuView =[FloatPartView defaultPositionView];
    menuView.menuCallBack = ^(FloatPartItemView *callbackResult) {
        
    };
    [self.view addSubview:menuView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
