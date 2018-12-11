//
//  ViewController.m
//  HRGCustomView
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUDTool.h"
#import "PromptView.h"

#define HRGScreenWidth [[UIScreen mainScreen] bounds].size.width
#define HRGScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@property (nonatomic, strong) PromptView *promptView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MBProgressHUDTool *progressHUD = [[MBProgressHUDTool alloc] init];
//    [progressHUD showHubWithLoadText:@"查询中..." superView:self.view];
    
    [self addPromptView];
}

- (void) addPromptView {
    if (!self.promptView) {
        self.promptView = [[PromptView alloc] initWithFrame:CGRectMake(0, 0, HRGScreenWidth, HRGScreenHeight)];
        [self.promptView setNilDataWithImagePath:@"icon_jzsb" tint:@"没有相关新闻" btnTitle:@""];
        [self.view addSubview:self.promptView];
    }
}

@end
