//
//  LoginInfoLocalData.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "HRGBaseLocalData.h"
#import <YYKit/YYKit.h>
#import "LoginModel.h"

/**
 登录信息数据
 */
@interface LoginInfoLocalData : HRGBaseLocalData

@property (nonatomic, retain) YYCache *yyCache;

+ (instancetype) sharedInstance;

// 帐号密码 信息
- (void) saveAccount:(NSString *)account psw:(NSString *)psw;
- (void) updateNewPassword:(NSString *)psw;
- (void) updateNewAccount:(NSString *)account;
- (NSString*) getAccount;
- (NSString*) getPassword;
- (void) clearInfo;// 清除登录信息

// 保存云信信息
- (void) saveAccid:(NSString *)accid token:(NSString *)token;
- (NSString *) nimAccid;
- (NSString *) nimToken;

- (void) saveLoginModel:(LoginModel *)loginModel;
- (LoginModel *) getLoginModel;
- (NSString *) getUserPhoto;
- (void) removeLoginModel;

@end
