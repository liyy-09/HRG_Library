//
//  PwdViewModel.m
//  HRGAccount
//
//  Created by lyy on 2018/12/18.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "PwdViewModel.h"
#import "DES3Util.h"

@implementation Password

@end

@implementation PwdViewModel

- (void) hrg_initialize {
    self.enableCodeSignal = [RACSubject combineLatest:@[RACObserve(self.password, phone)] reduce:^id(NSString *phone) {
        return @([DES3Util isMobileNumber:phone]);
    }];
    
    self.updateSignal = [RACSubject combineLatest:@[RACObserve(self.password, phone), RACObserve(self.password, code), RACObserve(self.password, oldPwd), RACObserve(self.password, pwd)] reduce:^id(NSString *phone, NSString *code, NSString *oldPwd, NSString *pwd) {
        return @(phone.length && code.length && oldPwd.length && pwd.length);
    }];
    
    self.forgetSignal = [RACSubject combineLatest:@[RACObserve(self.password, phone), RACObserve(self.password, code), RACObserve(self.password, pwd)] reduce:^id(NSString *phone, NSString *code, NSString *pwd) {
        return @(phone.length && code.length && pwd.length);
    }];
    
    [self.codeCommand.executionSignals.switchToLatest subscribeNext:^(NetDataReturnModel *model) {
        if (model.type == ReturnSuccess) {
            [self.codeSubject sendNext:@"1"];
        } else if (model.type == ReturnFailure) {
            [self.codeSubject sendNext:model.error];
        }
    }];
    
    [self.updateCommand.executionSignals.switchToLatest subscribeNext:^(NetDataReturnModel *model) {
        if (model.type == ReturnSuccess) {
            [self.updateSubject sendNext:@"1"];
        } else if (model.type == ReturnFailure) {
            [self.updateSubject sendNext:model.error];
        }
    }];
    
    [self.forgetCommand.executionSignals.switchToLatest subscribeNext:^(NetDataReturnModel *model) {
        if (model.type == ReturnSuccess) {
            [self.forgetSubject sendNext:@"1"];
        } else if (model.type == ReturnFailure) {
            [self.forgetSubject sendNext:model.error];
        }
    }];
}

#pragma mark - getter

- (RACCommand *) updateCommand {
    if (!_updateCommand) {
        _updateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
            NSDictionary *params = @{ @"randomCode" : (self.password.code ? self.password.code :@""),
                                      @"telephone" : (self.password.phone ? self.password.phone :@""),
                                      @"oldPassword" : (self.password.oldPwd ? self.password.oldPwd :@""),
                                      @"password" : (self.password.pwd ? self.password.pwd :@"")
                                      };
            
            return [self.request httpPostRequest:ChangePwd_url params:params requestModel:nil];
        }];
    }
    
    return _updateCommand;
}

- (RACCommand *) forgetCommand {
    if (!_forgetCommand) {
        _forgetCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
            NSDictionary *params = @{ @"randomCode" : (self.password.code ? self.password.code :@""),
                                      @"telephone" : (self.password.phone ? self.password.phone :@""),
                                      @"password" : (self.password.pwd ? self.password.pwd :@"")
                                      };
            
            return [self.request httpPostRequest:CheckSmsCode_url params:params requestModel:nil];
        }];
    }
    
    return _forgetCommand;
}

- (RACCommand *) codeCommand {
    if (!_codeCommand) {
        _codeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
            
            NSString *url = [NSString stringWithFormat:@"%@/%@", ForgetSmsCode_url, self.password.phone];
            
            return [self.request httpGetRequest:url params:nil requestModel:nil];
        }];
    }
    
    return _codeCommand;
}

- (RACSubject *)updateSubject {
    if (!_updateSubject) {
        _updateSubject = [[RACSubject alloc] init];
    }
    
    return _updateSubject;
}

- (RACSubject *)forgetSubject {
    if (!_forgetSubject) {
        _forgetSubject = [[RACSubject alloc] init];
    }
    
    return _forgetSubject;
}

- (RACSubject *)codeSubject {
    if (!_codeSubject) {
        _codeSubject = [[RACSubject alloc] init];
    }
    
    return _codeSubject;
}

- (Password *)password {
    if (_password == nil) {
        _password = [[Password alloc] init];
    }
    
    return _password;
}

@end
