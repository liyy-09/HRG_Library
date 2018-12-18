//
//  LoginViewModel.h
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseViewModel.h"

// 账户名或手机号加密码登录
#define Login_url               AccountHost"/member/login"
// 用户退出接口
#define Logout_url              AccountHost"/login/logout"

@interface Account : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;

@end

@interface LoginViewModel : HRGBaseViewModel

@property (nonatomic, strong) Account *account;

@property (nonatomic, strong) RACSubject *loginResultSubject;
@property (nonatomic, strong) RACCommand *loginCommand;

@property (nonatomic, strong) RACSubject *logoutSubject;
@property (nonatomic, strong) RACCommand *logoutCommand;

@end
