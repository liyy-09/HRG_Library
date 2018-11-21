//
//  LoginModel.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseModel.h"

@interface UserModel : HRGBaseModel

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *headPic;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *idcard;
@property (nonatomic, copy) NSString *socialcard;
@property (nonatomic, copy) NSString *memberPoint;  // 会员积分
@property (nonatomic, copy) NSString *memeberCode;  // 会员等级
@property (nonatomic, copy) NSString *wechat;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;

- (NSString *)memberDesc;

@end


/**
 登录成功后的实体类
 */
@interface LoginModel : HRGBaseModel

@property (nonatomic, copy) NSString *token;          // 用户票据编码
@property (nonatomic, strong) UserModel *user;

@end
