//
//  Target_Login.m
//  HRGAccount
//
//  Created by lyy on 2018/11/20.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "Target_Login.h"
#import "LoginViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void(^RouterCallBack)(NSString *);

@interface Target_Login ()

@property (nonatomic, copy) RouterCallBack callback;

@end

@implementation Target_Login

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    LoginViewController *vc = [[LoginViewController alloc] initWithStoryboard];
    
    self.callback = params[@"callback"];
    self.callback(@"这是路由回调的数据");
    
    return vc;
}

@end
