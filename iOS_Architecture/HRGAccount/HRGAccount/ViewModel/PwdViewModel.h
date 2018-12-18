//
//  PwdViewModel.h
//  HRGAccount
//
//  Created by lyy on 2018/12/18.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseViewModel.h"

// 更改密码检验验证码并更新密码
#define ChangePwd_url           AccountHost"/sys/member/changePwd"
// 忘记密码检验验证码并更新密码
#define CheckSmsCode_url        AccountHost"/sys/member/checkSmsCode"
// 更改密码/忘记密码的发送验证码
#define ForgetSmsCode_url       AccountHost"/sys/member/sendForgetSmsCode"

NS_ASSUME_NONNULL_BEGIN

@interface Password : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *oldPwd;
@property (nonatomic, copy) NSString *pwd;

@end

/**
 更新密码/忘记密码
 */
@interface PwdViewModel : HRGBaseViewModel

@property (nonatomic, strong) Password *password;

@property (nonatomic, strong) RACSignal *enableCodeSignal;
@property (nonatomic, strong) RACSignal *updateSignal;
@property (nonatomic, strong) RACSignal *forgetSignal;

@property (nonatomic, strong) RACSubject *updateSubject;
@property (nonatomic, strong) RACSubject *forgetSubject;
@property (nonatomic, strong) RACSubject *codeSubject;

@property (nonatomic, strong) RACCommand *updateCommand;
@property (nonatomic, strong) RACCommand *forgetCommand;
@property (nonatomic, strong) RACCommand *codeCommand;

@end

NS_ASSUME_NONNULL_END
