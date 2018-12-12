//
//  ViewController.m
//  HRGAccount
//
//  Created by lyy on 2018/12/11.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void) login {
    LoginViewController *controller = [[LoginViewController alloc] initWithSelfStoryborad];
    [controller.loginSuccessSubject subscribeNext:^(id x) {
        
    }];
    
    RTRootNavigationController *naviController = [[RTRootNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:naviController animated:YES completion:nil];
}

@end
