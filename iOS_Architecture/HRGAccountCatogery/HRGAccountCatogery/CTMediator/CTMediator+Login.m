//
//  CTMediator+Login.m
//  HRGAccountCatogery
//
//  Created by lyy on 2018/11/20.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "CTMediator+Login.h"

@implementation CTMediator (Login)

- (UIViewController *)Login_viewControllerWithCallback:(void(^)(NSString *result))callback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    return [self performTarget:@"Login" action:@"viewController" params:params shouldCacheTarget:NO];
}

@end
