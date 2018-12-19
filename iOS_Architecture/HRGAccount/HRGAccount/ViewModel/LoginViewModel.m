//
//  LoginViewModel.m
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginInfoLocalData.h"
#import "LoginModel.h"
#import "DES3Util.h"
#import "UseInfoLocalData.h"

@implementation Account

- (NSString *) account {
    return _account ? _account : @"";
}

- (NSString *)pwd {
    return _pwd ? _pwd : @"";
}

@end

@implementation LoginViewModel

- (void) hrg_initialize {
    [[self.loginCommand.executionSignals.switchToLatest deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NetDataReturnModel *model) {
        if (model.type == ReturnSuccess) {
            LoginModel *loginModel = [LoginModel convertFromDict:model.result];
            
            // 保存帐号信息
            [[LoginInfoLocalData sharedInstance] saveLoginModel:loginModel];
            [[LoginInfoLocalData sharedInstance] saveAccount:self.account.account psw:self.account.pwd];
            
            [self.loginResultSubject sendNext:@1];
        } else {
            NSString *tint = [model.error isEqualToString:@""] ? @"账号或密码错误" : model.error;
            [self.loginResultSubject sendNext:tint];
        }
    }];
    
    [self.logoutCommand.executionSignals.switchToLatest subscribeNext:^(NetDataReturnModel *model) {
        if (model.type == ReturnSuccess) {
            [self.logoutSubject sendNext:@1];
        } else {
            [self.logoutSubject sendNext:@0];
        }
    }];
}

#pragma mark - getter

- (Account *)account {
    if (_account == nil) {
        _account = [[Account alloc] init];
    }
    return _account;
}

- (RACCommand *) loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
            // 极光registrationID
            NSString *regid = [[UseInfoLocalData sharedInstance] getRegistrationID];
            
            NSDictionary *params = @{ @"telephone" : self.account.account,
                                      @"password" : self.account.pwd,
                                      @"regid" : (regid ? regid : @"")
                                      };
            return [self.request httpPostRequest:Login_url params:params requestModel:nil];
        }];
    }
    
    return _loginCommand;
}

- (RACCommand *) logoutCommand {
    if (!_logoutCommand) {
        _logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [self.request httpGetRequest:Logout_url params:nil requestModel:nil];
        }];
    }
    
    return _logoutCommand;
}

- (RACSubject *) loginResultSubject {
    if (!_loginResultSubject) {
        _loginResultSubject = [[RACSubject alloc] init];
    }
    
    return _loginResultSubject;
}

- (RACSubject *) logoutSubject {
    if (!_logoutSubject) {
        _logoutSubject = [[RACSubject alloc] init];
    }
    
    return _logoutSubject;
}

@end
