//
//  LoginViewController.h
//  SHAREMEDICINE_EMPLOYEE_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseAccountViewController.h"

@interface LoginViewController : HRGBaseAccountViewController

@property (nonatomic, strong) RACSubject *loginSuccessSubject;

- (instancetype) initWithSelfStoryborad;
- (instancetype) initWithStoryboard;

@end
