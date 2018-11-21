//
//  LoginViewModel.h
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseViewModel.h"

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
