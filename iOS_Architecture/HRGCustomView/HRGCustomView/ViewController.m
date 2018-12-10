//
//  ViewController.m
//  HRGCustomView
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUDTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUDTool *progressHUD = [[MBProgressHUDTool alloc] init];
    [progressHUD showHubWithLoadText:@"查询中..." superView:self.view];
}


@end
