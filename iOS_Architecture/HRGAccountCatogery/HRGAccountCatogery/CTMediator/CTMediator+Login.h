//
//  CTMediator+Login.h
//  HRGAccountCatogery
//
//  Created by lyy on 2018/11/20.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (Login)

- (UIViewController *)Login_viewControllerWithCallback:(void(^)(NSString *result))callback;

@end

NS_ASSUME_NONNULL_END
